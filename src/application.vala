/* application.vala
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
    public class Application : Adw.Application {
        public Application () {
            Object (application_id: "com.streamer272.ShutdownTimer", flags: ApplicationFlags.FLAGS_NONE);
        }

        construct {
            ActionEntry[] action_entries = {
                { "about", this.on_about_action },
                { "quit", this.quit }
            };
            this.add_action_entries (action_entries, this);
            this.set_accels_for_action ("app.quit", {"<primary>q"});
        }

        public override void activate () {
            base.activate ();
            var win = this.active_window;
            if (win == null) {
                win = new ShutdownTimer.Window (this);
            }
            win.present ();
        }

        private void on_about_action () {
            string[] authors = { "Daniel Svitan" };
            Gtk.show_about_dialog (this.active_window,
                                   "program-name", "shutdown-timer",
                                   "authors", authors,
                                   "version", "0.1.0");
        }
    }
}
