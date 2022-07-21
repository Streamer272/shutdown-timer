/* window.vala
 *
 * Copyright 2022 Daniel Svitan
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace ShutdownTimer {
    [GtkTemplate(ui = "/com/streamer272/ShutdownTimer/gtk/window.ui")]
    public class Window : Gtk.ApplicationWindow {
        [GtkChild]
        private unowned Gtk.Button button_cancel;
        [GtkChild]
        private unowned Gtk.DropDown dropdown_time;
        [GtkChild]
        private unowned Gtk.Entry entry_time;
        [GtkChild]
        private unowned Gtk.Button button_ok;

        public Window(Gtk.Application app) {
            Object(application: app);

            button_cancel.clicked.connect(cancel);
            entry_time.activate.connect(submit);
            button_ok.clicked.connect(submit);
        }

        public void submit() {
            uint at = dropdown_time.get_selected();
            string time = entry_time.get_text();

            string stdout;
            string stderr;
            int exit;
            if (at == 0) {
                try {
                    Process.spawn_command_line_sync(@"shutdown --halt $time", out stdout, out stderr, out exit);
                }
                catch (SpawnError e) {
                    if (exit != 0)
                        message(@"Failed with $exit");
                }
            }
            else {
                try {
                    Process.spawn_command_line_sync(@"shutdown --halt +$time", out stdout, out stderr, out exit);
                }
                catch (SpawnError e) {
                    if (exit != 0)
                        message(@"Failed with $exit");
                }
            }
        }

        public void cancel() {
            string stdout;
            string stderr;
            int exit;
            try {
                Process.spawn_command_line_sync(@"shutdown -c", out stdout, out stderr, out exit);
            }
            catch (SpawnError e) {
                if (exit != 0)
                    message(@"Failed with $exit");
            }
        }
    }
}
