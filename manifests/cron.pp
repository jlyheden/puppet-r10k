class r10k::cron(
  $ensure    = 'present',
  $frequency = 'UNDEF',
  $user      = 'root',
  $group     = 0
) {

  $minute_real = $frequency ? {
    'UNDEF' => interval(3,60)
    default => $frequency
  }

  include r10k
  include r10k::params

  cron { 'r10k full synchronization':
    ensure  => $ensure,
    user    => $user,
    command => "${r10k::params::r10k_bin} synchronize",
    minute  => $minute_real,
    require => Class['r10k'],
  }
}
