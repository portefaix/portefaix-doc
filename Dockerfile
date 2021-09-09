# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM klakegg/hugo:ext-alpine as hugo

RUN apk add git npm

COPY package.json package-lock.json /hugodir/

RUN npm install

COPY ./ /hugodir

WORKDIR /hugodir
RUN hugo --config ./config.toml

FROM nginx:alpine
COPY --from=hugo /hugodir/public /usr/share/nginx/html

WORKDIR /usr/share/nginx/html
