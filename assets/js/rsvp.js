import $ from 'jquery';

function response_done(data, status, _xhr) {
    console.log("updated", status, data);
}

function send_response(invite_id, response) {
    let body = {invite: {invite_id, response}};
    let url = "/api/response/" + invite_id;

    $.ajax(url, {
        method: "patch",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: JSON.stringify(body),
        success: response_done,
        error: console.log,
    });
}

function setup() {
    $(".rsvp-containter").each((_ii, buttons) => {
        let invite_id = $(buttons).data('invite-id');

        $(buttons).find('.yes-btn').click(() => {
            send_response(invite_id, 1);
        });
        $(buttons).find('.no-btn').click(() => {
            send_response(invite_id, 0);
        });
        $(buttons).find('.maybe-btn').click(() => {
            send_response(invite_id, 2);
        });
    });
}

$(setup);