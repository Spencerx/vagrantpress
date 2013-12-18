#!/bin/sh

set -eu

WP_USER=wordpress
WP_PASS=wordpress
WP_DATABASE=wordpress
WP_DOMAIN=wpdev

execute_query () {
  local query="$1"
  echo "$query" | mysql --skip-column-names -u "$WP_USER" --password="$WP_PASS" "$WP_DATABASE"
}

execute_query "update wp_site set domain = CONCAT(REPLACE(domain, '.', '-'), '.${WP_DOMAIN}');"
execute_query "update wp_blogs set domain = CONCAT(REPLACE(domain, '.', '-'), '.${WP_DOMAIN}');"
execute_query "update wp_sitemeta set meta_value = CONCAT(REPLACE(meta_value, '.', '-'), '.${WP_DOMAIN}') where meta_key = 'siteurl';"
execute_query "update wp_options set option_value = CONCAT(REPLACE(TRIM(TRAILING '/' FROM option_value), '.', '-'), '.${WP_DOMAIN}') where option_name IN ('siteurl', 'home');"

execute_query "show tables like 'wp_%_options';" |
while read table; do
  execute_query "update ${table} set option_value = CONCAT(REPLACE(TRIM(TRAILING '/' FROM option_value), '.', '-'), '.${WP_DOMAIN}') where option_name IN ('siteurl', 'home');"
done
