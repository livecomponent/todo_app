import { live, LiveController } from "@camertron/live-component";

@live("TodoItemComponent") // this is the Ruby class name
export class TodoItemComponent extends LiveController {
  edit() {
    this.render((component) => {
      component.props.editing = true;
    });
  }
}
