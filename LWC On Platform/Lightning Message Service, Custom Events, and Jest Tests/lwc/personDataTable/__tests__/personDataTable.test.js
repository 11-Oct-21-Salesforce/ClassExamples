import { createElement } from 'lwc';
import PersonDataTable from 'c/personDataTable';
import getRecords from '@salesforce/apex/RecordService.getRecords';

const getRecordsResult = require('./data/contacts.json');

describe('c-person-data-table', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });

    it('Testing retrieval of contact data', () => {
        const element = createElement('c-person-data-table', {
            is: PersonDataTable
        });
        document.body.appendChild(element);

        element.chosenObject = 'Contact';

        getRecords.emit(getRecordsResult);

        return Promise.resolve().then(() => {
            const dataTable = element.shadowRoot.querySelector('lightning-datatable');
            expect(dataTable.data).not.toBeNull();
            expect(dataTable.data).toStrictEqual(getRecordsResult);
            expect(dataTable.columns).toStrictEqual([
                {label: 'Name', fieldName: 'Name'},
                {label: 'Email', fieldName: 'Email', type: 'email'},
                {label: 'Phone', fieldName: 'Phone', type: 'phone'}
            ]);
        })
    });
});