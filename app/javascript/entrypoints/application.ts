import { Application as LiveComponentApplication } from "@camertron/live-component";
import { Application as StimulusApplication } from "@hotwired/stimulus"
import "@hotwired/turbo-rails"

import "app/components/todo_item_component"

declare global {
  interface Window {
    Stimulus: StimulusApplication;
    Live: LiveComponentApplication;
  }
}

window.Stimulus = StimulusApplication.start();
window.Live = LiveComponentApplication.start(window.Stimulus);
