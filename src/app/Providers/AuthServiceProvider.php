<?php

namespace App\Providers;

use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use App\CognitoJWT;
use Firebase\JWT\ExpiredException;
use App\User;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The policy mappings for the application.
     *
     * @var array
     */
    protected $policies = [
        // 'App\Model' => 'App\Policies\ModelPolicy',
    ];

    /**
     * Register any authentication / authorization services.
     *
     * @return void
     */
    public function boot()
    {
        $this->registerPolicies();

        Auth::viaRequest('cognito', function ($request) {
            $jwt = $request->bearerToken();
            $region = env('AWS_REGION', '');
            $userPoolId = env('AWS_COGNITO_USER_POOL_ID', '');
            if ($jwt) {
                try {
                    $user = cache($jwt, null);
                    if ($user) {
                        return $user;
                    } else {
                        $u = CognitoJWT::verifyToken($jwt, $region, $userPoolId);
                        if (isset($u)) {
                            $e = substr($u->email, 12, 10);
                            $user = User::where('member_id', $e)->first();
                            if ($user) {
                                cache()->put($jwt, $user, 60*60);
                            }
                            return $user;
                        }
                    }
                } catch (ExpiredException $e) {
                    return null;
                }
            }
            return null;
        });
    }
}
