/**
 * 경로 검색에 대한 smoke test
 */
import { URL } from 'https://jslib.k6.io/url/1.0.0/index.js';
import http from 'k6/http';
import { check, sleep } from 'k6';
import { login, generateAuthorizationHeaderWith } from '../login.js';

export let options = {
  stages: [
    { duration: '1m', target: 9 }, // simulate ramp-up of traffic from 1 to 9 users over 1 minutes.
    { duration: '10m', target: 9 }, // stay at 9 users for 10 minutes
    { duration: '10s', target: 0 }, // ramp-down to 0 users
  ],
  thresholds: {
    http_req_duration: ['p(99)<500'], // 99% of requests must complete below 0.5s,
  },
};

const BASE_URL = 'https://writer0713.o-r.kr';

export default function () {
  getAllStations();
  getPath();
  addToFavorite();
}

/**
 * 역정보 모두 가져오기
 */
function getAllStations() {
  var params = {
    headers: {
      'Content-Type': 'application/json',
    },
  };

  let stationsRes = http.get(`${BASE_URL}/stations`, params);

  check(stationsRes, {
    'Successfully Got Stations JSON': (resp) => resp.json().length >= 615,
  });
  sleep(1);
}

function getPath() {
  var headers = {
    headers: {
      'Content-Type': 'application/json',
    },
  };
  const url = new URL(`${BASE_URL}/paths`);
  url.searchParams.append('source', 1);
  url.searchParams.append('target', 15);

  const response = http.get(url.toString(), headers);

  check(response, {
    'Successfully Got Path': (resp) => resp.json().distance === 27,
  });
  sleep(1);
}

function addToFavorite() {
  const auth_header = generateAuthorizationHeaderWith(login());

  var payload = JSON.stringify({
    source: 1,
    target: 15,
  });

  const url = new URL(`${BASE_URL}/favorites`);
  const response = http.post(url.toString(), payload, auth_header);

  check(response, {
    'Successfully Add To Favorites': (res) => res.status === 201,
  });
  sleep(1);
}
