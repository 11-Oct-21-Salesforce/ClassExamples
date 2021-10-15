
import { createElement } from 'lwc';
import MyEventParent from 'my/eventParent';

const app = createElement('my-event-parent', { is: MyEventParent });
// eslint-disable-next-line @lwc/lwc/no-document-query
document.querySelector('#main').appendChild(app);
