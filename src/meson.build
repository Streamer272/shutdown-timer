shutdown_timer_sources = [
  'main.vala',
  'window.vala',
  'application.vala',
]

shutdown_timer_deps = [
  dependency('gtk4'),
  dependency('libadwaita-1')
]

gnome = import('gnome')

shutdown_timer_sources += gnome.compile_resources('shutdown_timer-resources',
  'shutdown_timer.gresource.xml',
  c_name: 'shutdown_timer'
)

executable('shutdown-timer', shutdown_timer_sources,
  vala_args: '--target-glib=2.50',  dependencies: shutdown_timer_deps,
  install: true,
)
