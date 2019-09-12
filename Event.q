event:([name:`$()]time:`time$();fun:();startTime:`timestamp$();endTime:`timestamp$();lastRun:`timestamp$();nextRun:`timestamp$());
eventHist:([]fun:();startTime:`timestamp$();endTime:`timestamp$();error:();status:`$());

`event insert (`;0Wt;::;-0Wp;0Wp;0Np;0Np);
`eventHist insert (::;0Wp;0Wp;enlist " ";`);

addEvent:{[d] event::event upsert (d`name;d`time;d`fun;d`st;d`et;0Np;.z.d+d`time)}
deleteEvent:{[d] event::delete from event where name=d}

runEvent:{ da:exec name,fun from event where nextRun<.z.p,endTime>.z.p,not name=`;
	if [0<count da`name; event::update nextRun:nextRun+1D,lastRun:.z.p from event where name in da`name ; 
		{show "Running ";st:.z.p; error:"";status:`SUCCESS;s:@[x;`;{x,"_Error"}];et:.z.p;if[10h~type s;if[ s like "*Error";status:`FAIL;error:("_"vs s)[0]]];`eventHist insert (x;st;et;error;status)} each da`fun];
		 };

.z.ts:{runEvent[]};
value"\\t 100";

addEvent[`name`time`fun`st`et!(`event1;.z.t+00:00:05;{show "Hello Event";10+10};.z.P;0Wp)];
addEvent[`name`time`fun`st`et!(`event2;.z.t+00:00:05;{show "Hello Event";10+"10"};.z.P;0Wp)];
addEvent[`name`time`fun`st`et!(`event3;.z.t+00:00:05;{10+10};.z.P;0Wp)];
addEvent[`name`time`fun`st`et!(`event3;.z.t+00:00:05;{10+10*h};.z.P;0Wp)];