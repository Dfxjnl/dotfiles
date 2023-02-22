user_pref("browser.safebrowsing.downloads.remote.enabled", true); // 0403

/* override recipe: enable session restore ***/
user_pref("browser.startup.page", 3); // 0102
// user_pref("browser.privatebrowsing.autostart", false); // 0110 required if you had it set as true
// user_pref("browser.sessionstore.privacy_level", 0); // 1003 optional to restore cookies/formdata
// user_pref("privacy.cpd.history", false); // 2820 optional to match when you use Ctrl-Shift-Del

user_pref("network.http.referer.XOriginPolicy", 0); //1601

/* 2811 */
user_pref("privacy.clearOnShutdown.cache", false); // [DEFAULT: true]
user_pref("privacy.clearOnShutdown.downloads", false); // [DEFAULT: true]
user_pref("privacy.clearOnShutdown.formdata", false); // [DEFAULT: true]
user_pref("privacy.clearOnShutdown.history", false); // [DEFAULT: true]
user_pref("privacy.clearOnShutdown.sessions", false); // [DEFAULT: true]

/* override recipe: RFP is not for me ***/
user_pref("privacy.resistFingerprinting", false); // 4501
user_pref("privacy.resistFingerprinting.letterboxing", false); // 4504 [pointless if not using RFP]
user_pref("webgl.disabled", false); // 4520 [mostly pointless if not using RFP]
