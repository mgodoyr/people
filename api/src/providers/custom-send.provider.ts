import {Send, Response, OperationRetval} from '@loopback/rest';
import {Provider, BoundValue, inject} from '@loopback/core';
import {writeResultToResponse, RestBindings, Request} from '@loopback/rest';

// Note: This is an example class; we do not provide this for you.

class Formatter {
    private _result: any;
    private _header: any;
    convertToMimeType(result: any, header: any) {
        this._result = result;
        this._header = header;
        return {}
    }
}

export class CustomSendProvider implements Provider<Send> {
    // In this example, the injection key for formatter is simple
    constructor(
        @inject('utils.formatter') public formatter: Formatter,
        @inject(RestBindings.Http.REQUEST) public request: Request,
    ) {}

    value() {
        // Use the lambda syntax to preserve the "this" scope for future calls!
        return (response: Response, result: OperationRetval) => {
            this.action(response, result);
        };
    }
    /**
     * Use the mimeType given in the request's Accept header to convert
     * the response object!
     * @param response - The response object used to reply to the  client.
     * @param result - The result of the operation carried out by the controller's
     * handling function.
     */
    action(response: Response, result: OperationRetval) {
        if (result) {
            // Currently, the headers interface doesn't allow arbitrary string keys!
            const headers = (this.request.headers as any) || {};
            const header = headers.accept || 'application/json';
            const formattedResult = this.formatter.convertToMimeType(result, header);
            response.setHeader('Content-Type', header);
            response.end(formattedResult);
        } else {
            response.end();
        }
    }
}