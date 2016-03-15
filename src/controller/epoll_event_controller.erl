-module(epoll_event_controller, [Req]).
-compile(export_all).

%% list events
index('GET', []) ->
    Events = boss_db:find(event, []),
    {ok, [{title, "Event List"}, {events, Events}]}.

%% add new event
add('GET', []) ->
    ok;
add('POST', []) ->
    Name = Req:post_param("name"),
    Description = Req:post_param("description"),
    Event = event:new(id, Name, Description),
    {ok, SaveEvent} = Event:save(),
    {redirect, "/event"}.

%% view event profile
view('GET', [Name]) ->
    Event = boss_db:find_first(event, [{name, Name}]),
    {ok, [{name, Name}, {event, Event}]}.

%% test
test('GET', []) ->
    Events = boss_db:find(event, []),
    %%{ok, [{title, "Event List"}, {events, Events}]}.
    {json, [{success, true}, {message, "Hello monkey."}]}.
