(function () {
  const $ = (q, el = document) => el.querySelector(q);

  // Footer year
  const y = $("#year");
  if (y) y.textContent = String(new Date().getFullYear());

  // Mobile nav toggle
  const toggle = $(".nav-toggle");
  const navlinks = $("#navlinks");
  if (toggle && navlinks) {
    toggle.addEventListener("click", () => {
      const open = navlinks.classList.toggle("open");
      toggle.setAttribute("aria-expanded", open ? "true" : "false");
    });
    navlinks.addEventListener("click", (e) => {
      const a = e.target && e.target.closest ? e.target.closest("a") : null;
      if (a) navlinks.classList.remove("open");
    });
    document.addEventListener("click", (e) => {
      if (!navlinks.classList.contains("open")) return;
      const within = e.target && e.target.closest ? e.target.closest(".nav") : null;
      if (!within) navlinks.classList.remove("open");
    });
  }

  // Gallery section removed - no longer needed
})();

/* Image fallback handlers (replaces inline onerror so CSP can be strict) */
document.addEventListener("DOMContentLoaded", function () {
  // Hero image fallback
  var hero = document.getElementById("heroImg");
  if (hero) {
    hero.addEventListener("error", function () {
      try {
        var frame = hero.closest(".media-frame");
        if (frame) frame.classList.add("noimg");
        hero.remove();
      } catch (e) { /* noop */ }
    }, { once: true });
  }

  // Staff image fallback
  var staff = document.getElementById("staffImg");
  if (staff) {
    staff.addEventListener("error", function () {
      try {
        staff.style.display = "none";
        var parent = staff.closest(".about-image");
        if (parent) parent.classList.add("noimg");
      } catch (e) { /* noop */ }
    }, { once: true });
  }
});

/* Event inquiry form */
document.addEventListener("DOMContentLoaded", function () {
  var form = document.getElementById("eventForm");
  if (!form) return;

  function getParam(name) {
    try {
      var u = new URL(window.location.href);
      return u.searchParams.get(name) || "";
    } catch (e) {
      return "";
    }
  }

  // Source attribution: ?src=van1 or UTM fallbacks
  var src = getParam("src") || getParam("utm_source") || getParam("utm_campaign") || "direct";
  var srcEl = document.getElementById("src");
  if (srcEl) srcEl.value = src;

  // Form elements
  var guestsEl = document.getElementById("guests");
  var hintEl = document.getElementById("depositHint");
  var statusEl = document.getElementById("formStatus");
  var btn = document.getElementById("submitBtn");
  var dateEl = document.getElementById("eventDate");

  // Set minimum date to today in UTC (prevents past dates in date picker)
  // HTML5 date inputs interpret the min attribute in the user's local timezone.
  // We set it to UTC today so that validation (which uses UTC) accepts dates
  // that the picker allows. This ensures consistency: if it's already tomorrow
  // in UTC, users will see tomorrow as the minimum (which is correct).
  // Example: At 9 PM PST on Dec 30 (5 AM UTC Dec 31), min is set to Dec 31,
  // preventing selection of Dec 30 which would be rejected by validation.
  if (dateEl) {
    var today = new Date();
    // Get today's date in UTC (YYYY-MM-DD format)
    var todayStr = today.toISOString().split("T")[0];
    dateEl.setAttribute("min", todayStr);
  }

  // Deposit hint for 13+ guests
  function updateHint() {
    if (!guestsEl || !hintEl) return;
    var n = Number(guestsEl.value || 0);
    if (n >= 13) hintEl.textContent = "Groups of 13+ typically require a deposit to confirm the booking.";
    else if (n > 0) hintEl.textContent = "";
  }
  if (guestsEl) guestsEl.addEventListener("input", updateHint);
  updateHint();

  function setStatus(msg) {
    if (statusEl) statusEl.textContent = msg || "";
  }

  function payloadFromForm() {
    var fd = new FormData(form);
    var obj = {};
    fd.forEach(function (v, k) { obj[k] = String(v || "").trim(); });
    obj.userAgent = navigator.userAgent;
    obj.pageUrl = window.location.href;
    return obj;
  }

  form.addEventListener("submit", async function (e) {
    e.preventDefault();
    setStatus("");

    // Basic client-side required checks
    if (!form.checkValidity()) {
      setStatus("Please fill in all required fields.");
      form.reportValidity();
      return;
    }

    // Validate date is not in the past (using UTC to match server validation)
    // The server parses date strings as UTC (e.g., "2025-12-30" becomes "2025-12-30T00:00:00Z").
    // To match server behavior and prevent mismatches, we parse the selected date the same way.
    // Note: This means if a user selects "today" in their local timezone but it's already
    // "tomorrow" in UTC, validation will reject it (matching server behavior).
    if (dateEl && dateEl.value) {
      // Parse selected date as UTC midnight (matches server parsing)
      var selected = new Date(dateEl.value + "T00:00:00Z");
      // Get today's date in UTC
      var today = new Date();
      var todayStr = today.toISOString().split("T")[0];
      var todayUTC = new Date(todayStr + "T00:00:00Z");
      if (selected < todayUTC) {
        setStatus("Event date cannot be in the past. Please select a future date.");
        dateEl.focus();
        return;
      }
    }

    // Validate guests count matches server-side limits (1-200)
    if (guestsEl && guestsEl.value) {
      var guests = Number(guestsEl.value);
      if (!Number.isFinite(guests) || guests < 1 || guests > 200) {
        setStatus("Number of guests must be between 1 and 200.");
        guestsEl.focus();
        return;
      }
    }

    // Honeypot
    var hp = document.getElementById("company");
    if (hp && hp.value && hp.value.trim().length > 0) {
      setStatus("Thanks!");
      return;
    }

    if (btn) { btn.disabled = true; btn.textContent = "Sending…"; }
    try {
      var res = await fetch("/api/inquiry", {
        method: "POST",
        headers: { "Content-Type": "application/json; charset=utf-8" },
        body: JSON.stringify(payloadFromForm())
      });
      var data = null;
      try { data = await res.json(); } catch (e2) { data = {}; }

      if (!res.ok) {
        throw new Error(data && data.error ? data.error : "Request failed");
      }
      // Redirect to a clean confirmation screen for presentation clarity
      // Keep a fallback message in case navigation is blocked.
      setStatus("Request received. Redirecting…");
      var id = (data && data.id) ? String(data.id) : "";
      var qs = new URLSearchParams();
      if (id) qs.set("id", id);
      if (src) qs.set("src", src);
      window.location.href = "/thank-you.html" + (qs.toString() ? ("?" + qs.toString()) : "");
    } catch (err) {
      setStatus("Couldn't send right now. Please call (715) 393-4026.");
      console.error(err);
    } finally {
      if (btn) { btn.disabled = false; btn.textContent = "Send Request"; }
    }
  });
});
