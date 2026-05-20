<apex:includeScript value="/support/console/59.0/integration.js"/>

<script>
    window.setConsoleTabTitle = function() {
        try {
            var title = "{!JSENCODE(sourceId)}";

            if (title && title.trim() !== "" && window.sforce && sforce.console) {
                sforce.console.getEnclosingPrimaryTabId(function(res) {
                    if (res.success && res.id) {
                        sforce.console.setTabTitle(title, res.id);
                    }
                });
            }
        } catch (e) {
            if (window.console) {
                console.log(e);
            }
        }
    };

    window.onload = function() {
        updateTime();
        setInterval(updateTime, 1000);

        window.setConsoleTabTitle();
        setTimeout(window.setConsoleTabTitle, 1000);
        setTimeout(window.setConsoleTabTitle, 2500);
    };
</script>
sforce.console.getEnclosingTabId(function(res) {
    if (res.success && res.id) {
        sforce.console.setTabTitle(title, res.id);
    }
});
