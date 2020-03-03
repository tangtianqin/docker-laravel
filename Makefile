up:
	docker-compose up -d
build:
	docker-compose build
create-project:
	cp .env-example .env
	docker-compose up -d --build
	docker-compose exec app composer create-project --prefer-dist laravel/laravel .
	docker-compose exec app composer require predis/predis
install:
	docker-compose up -d --build
	docker-compose exec app composer install
	docker-compose exec app cp .env.example .env
	docker-compose exec app php artisan key:generate
	# docker-compose exec app php artisan migrate:fresh --seed
reinstall:
	@make destroy
	@make install
stop:
	docker-compose stop
restart:
	docker-compose restart
down:
	docker-compose down
destroy:
	docker-compose down --rmi all --volumes
ps:
	docker-compose ps
app:
	docker-compose exec app ash -l
fresh:
	docker-compose exec app php artisan migrate:fresh
seed:
	docker-compose exec app php artisan db:seed
tinker:
	docker-compose exec app php artisan tinker
dump:
	docker-compose exec app php artisan dump-server
test:
	docker-compose exec app php ./vendor/bin/phpunit
cache:
	docker-compose exec app composer dump-autoload -o
	docker-compose exec app php artisan optimize:clear
	docker-compose exec app php artisan optimize
cache-clear:
	docker-compose exec app php artisan optimize:clear
cs:
	docker-compose exec app ./vendor/bin/phpcs
cbf:
	docker-compose exec app ./vendor/bin/phpcbf
db:
	docker-compose exec db bash
db-testing:
	docker-compose exec db-testing bash
mysql:
	docker-compose exec db bash -c 'mysql -u $$MYSQL_USER -p$$MYSQL_PASSWORD $$MYSQL_DATABASE'
mysql-testing:
	docker-compose exec db-testing bash -c 'mysql -u $$MYSQL_USER -p$$MYSQL_PASSWORD $$MYSQL_DATABASE'
node:
	docker-compose exec node ash
npm:
	docker-compose exec node npm install
	docker-compose exec node npm run dev
yarn:
	docker-compose exec node yarn
	docker-compose exec node yarn run dev
token: 
	aws cognito-idp initiate-auth --auth-flow REFRESH_TOKEN_AUTH --client-id 2uml48s5nfpm33jeblabpn6ucf  --auth-parameters SECRET_HASH=2amj32efe0i7766se6hi86nm3t1g0gnrb5a6pnammnqv8n1buek,REFRESH_TOKEN=eyJjdHkiOiJKV1QiLCJlbmMiOiJBMjU2R0NNIiwiYWxnIjoiUlNBLU9BRVAifQ.FBVfWaenxzKfjWCgAOQoi3N-IGIWkItcvPtVJ0qa9uPbS9maTRbfk8vgSk4RNMAfQeqN1amUcVOZVbpIsAscf4A064hg8FqUZCs-CGDLL_kl-jPpgpn6gxe30R_LtMTA0puOayf9y6yiiTtAMCc5fmmftR3IY1iKhmqGkoU8p4k-eF-j5tsI-wD84z0MpG4Ce_BaxH054mpiPMz8Srtjaj48QmAFO2FogDA6fSNq-aD3JaeELa0UEI_GoHUfLG7gEa89Db4dm2JXuFPqm-hgnSVkVGVEFc8jdVcaJzJvpwwiXl3rNVKPKzjgmOTINMTMLH_Q9ybsL0CtByVp_u-MHw.gYfeV86rIBBDge2w.8sX7SEGNfhuntt3LPeltJfmBzco9i4jN5DlEI5fehfWkQS_XZa2j22NGE6jR-epm6e7P90GToUkrjtTVm_xgqYt8Wsq1RPGgqS-xO8MxULazUYiv1WIFhY62jl6AVWmaZeGOGJr8KKrxGBoEq3si0WFnMY2veUtVTR9VvW3rVHhUEQs-ICo8UzEh1r6oqAVvjzA2NUe-mL_w_g8WA7Uz_d_-TqLpA3u_pMz1twTMbdaZKG_qT8boPLNRuMZd8BdMBHuQ2MkITe3BndlWkncwaVs_GiNDBrUtXBVdoX4hzUsKfOkRXt-PqZo531csHEL9wfDD4AXUJRxAq_c7IxN11sDBjBq9QPk5fSAa5c67AzFVqda_OqvPVDi3aHzuvPPEpdSZDcdZqYyqhlQRPJ7gOA2zaQ04UlZ3BpJ-WxVcMus3AhrwkyCze1yC58ocTTKDguM4OoY9df2lY_goBkAFbCVFslr0nWQBFWam4dNSPNF0wOOnVz2o4ItGV4_IlR7KP-M_nGkVhLtiScZkpawe5_65wGlA5i9lyfWiv7qxH5ghMBUt_joH9UrPzxqC6RKKGvriO4H0gL7ZmATLMm08UcwRpk_U8Sx5vX10t_0UaAnkvSg8D9gl5ljWGKcpeOpDkPL03XBML7NN4vkdcjJxzEFstI-3bzlES7kk3UyJmCXmGTWj6zVGtw9qZ12dsCF4glBT71NdI7gCI4S1XdNxAGThykXUmHjAI7erNFifSzublMdVrcS_4N96Fkcvo39YG9zzuCD9oVHqXu1AViuxiRMlfoBHHbSTt6fwqtGMPgiVadZ7WSbDpjh8vLx28_3v5pS3WYQ5k9IDpsOZFmswHUhjlNNi3HCnUPQeb3lncOUpA9KPS4G7yU0uMEl-a25Dw8028j4lc8oGb-7jj2o3ktILoTAHnXK99SjJcXJ_Fu7VaWzElCLR0lG_Bd9xXPA3hgQgBOPv9H7ulaGzrgcUIncBu-br571suLSHgRUYGkuwit0B95Ylol9uZwWkOenTHwuqdlhIOvo8IqPczf-CutyJ5ckV5Nq9sv4fX9-XLgRCdsW_ylkJppSpwrJubiqCdJz6A4Hm0pU5TcUwxq0RUWQ0MYQFghUSmHZt9oPcQPJdf9DzyKU3rV8h-hHZ0A8ZMJc-qIbuDjN-4lTZGTtw9DsY9AV4xYpPbrh9t4vyjsSvKLc5jCAepTVHU_s5tZ3xkjqwOW-hMKRH5oMkCqWdoC3H4_4IQq_IhVWJWhbqTWUo33i5Z3JqvSysdqAGHnc5lSB-hWynnALu_4ssHKrtLun9yH1f2p9l0YmgU_ESXTjkwMWujojFzjZin0r6S9xmxe10F1ma0Og9.SGqnDgMa-5SWGQInTTUvWw