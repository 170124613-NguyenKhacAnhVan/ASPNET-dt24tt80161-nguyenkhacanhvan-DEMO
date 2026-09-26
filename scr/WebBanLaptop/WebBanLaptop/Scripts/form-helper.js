document.addEventListener("DOMContentLoaded", function () {
    var inputs = document.querySelectorAll(".form-control");

    inputs.forEach(function (input) {
        ["focus", "input"].forEach(function (eventName) {
            input.addEventListener(eventName, function () {

                if (this.Validators) {
                    for (var i = 0; i < this.Validators.length; i++) {
                        this.Validators[i].style.display = "none";
                    }
                }

                var wrapper = this.closest(".mb-3, .col-md-6, .col-12, .field-group");
                if (wrapper) {
                    var errorSpans = wrapper.querySelectorAll("span.text-danger");
                    errorSpans.forEach(function (span) {
                        span.style.display = "none";
                    });
                }

                var summaries = document.querySelectorAll("[data-valsummary='true'], .validation-summary");
                summaries.forEach(function (summary) {
                    summary.style.display = "none";
                });

                var serverAlerts = document.querySelectorAll(".alert");
                serverAlerts.forEach(function (alertBox) {
                    alertBox.style.display = "none";
                });
            });
        });
    });
});