import $ from 'jquery';

function response_done(data, status, _xhr) {
    console.log("updated", status, data);
}

function send_response(event_id, response) {
    let body = {invite: {event_id, response}};

    $.ajax("/api/invites", {
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: JSON.stringify(body),
        headers: {},
        success: response_done,
        error: console.log,
    });
}

function setup() {
    $(".rsvp-containter").each((_ii, buttons) => {
        let id = $(buttons).data('event-id');

        $(buttons).find('.yes-btn').click(() => {
            send_response(id, 1);
        });
        $(buttons).find('.no-btn').click(() => {
            send_response(id, 0);
        });
        $(buttons).find('.maybe-btn').click(() => {
            send_response(id, 2);
        });
    });
}

$(setup);