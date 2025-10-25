async function registerServiceWorker() {
  const oldRegistrations = await navigator.serviceWorker.getRegistrations();
  for (const registration of oldRegistrations) {
    if (registration.installing.state === "installing") {
      return;
    }
  }

  const workerUrl =
    import.meta.env.MODE === "production"
      ? "/rails.sw.js"
      : "/dev-sw.js?dev-sw";

  await navigator.serviceWorker.register(workerUrl, {
    scope: "/",
    type: "module",
  });
}

async function boot() {
  if (!("serviceWorker" in navigator)) {
    console.error("Service Worker is not supported in this browser.");
    return;
  }

  if (!navigator.serviceWorker.controller) {
    await registerServiceWorker();

    console.log("Waiting for Service Worker to activate...");
  } else {
    console.log("Service Worker already active.");
  }

  navigator.serviceWorker.addEventListener("message", function (event) {
    switch (event.data.type) {
      case "progress": {
        console.log(`Loading progress ${event.data.step} ${event.data.value}`);
        break;
      }
      case "console": {
        console.log(event.data.message);
        break;
      }
      default: {
        console.log("Unknown message type:", event.data.type);
      }
    }
  });

  return await navigator.serviceWorker.ready;
}

async function init() {
  const registration = await boot();
  if (!registration) return;

  window.location.href = "/";
}

init();
