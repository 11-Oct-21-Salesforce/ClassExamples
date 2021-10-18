
/*
    The index.html and index.js files are the entry point for our application.
    When a user visits our webpage, the LWC OSS framework renders the contents of the index.html file
    and the code in the index.js file is executed.
*/

// we're importing synthetic-shadow to allow the use of slds
import '@lwc/synthetic-shadow';

// createElement is a method from the core lwc module that is used to render LWCs
import { createElement } from 'lwc';



/*
    When we export the class in our JS modules, we're making it available for other JS files to 
    import.

    To import from a module, we use the import statement. Because the class exported from our JS
    modules is a default export, we don't need to include the curly braces in the import statement.
    Importing a default export also allows us to name the import whatever we want. In the import
    statement, we pass the path to the module after the from keyword. This path is relative to the
    'modules' folder. The default component is named 'app' and it exists in the 'my' namespace folder,
    so the path is my/app.

*/
import MyApp from 'my/app';

/*
    We use the imported createElement method to create our imported component. We pass the name of
    the component as the first parameter (with kebab case in the format namespace-component-name)
    and an object literal as the second parameter. The object literal uses the is property, to specify
    the imported component class's construtor method as the constructor to invoke to create the
    element..
*/
const app = createElement('my-app', { is: MyApp });
// eslint-disable-next-line @lwc/lwc/no-document-query

/*
    Now that we've instantiated the imported component, we insert it into the DOM. First we retrieve
    the div element with the 'main' id from index.html and then we use the appendChild method to
    add our component as a child of the div element.
*/
document.querySelector('#main').appendChild(app);
