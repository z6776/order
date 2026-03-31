<?php

return [
    'autoload' => false,
    'hooks' => [
        'epay_config_init' => [
            'epay',
        ],
        'addon_action_begin' => [
            'epay',
        ],
        'action_begin' => [
            'epay',
            'third',
        ],
        'config_init' => [
            'nkeditor',
            'third',
        ],
        'app_init' => [
            'qrcode',
            'sythumb',
        ],
        'upload_after' => [
            'sythumb',
        ],
        'user_delete_successed' => [
            'third',
        ],
        'user_logout_successed' => [
            'third',
        ],
        'module_init' => [
            'third',
        ],
        'view_filter' => [
            'third',
        ],
    ],
    'route' => [
        '/qrcode$' => 'qrcode/index/index',
        '/qrcode/build$' => 'qrcode/index/build',
        '/third$' => 'third/index/index',
        '/third/connect/[:platform]' => 'third/index/connect',
        '/third/callback/[:platform]' => 'third/index/callback',
        '/third/bind/[:platform]' => 'third/index/bind',
        '/third/unbind/[:platform]' => 'third/index/unbind',
    ],
    'priority' => [],
    'domain' => '',
];
