set echo off
set feed off
select
	r.segment_name		segment_name,
	r.owner			owner,	
	r.tablespace_name	tablespace_name,
	r.status		status,
	r.initial_extent/1024/1024	initial_extent,
	r.next_extent/1024/1024	next_extent,
	s.extents		extents,
	ROUND(s.rssize/1024/1024)	rssize,
	s.xacts			active_trans
from
	dba_rollback_segs r,
	v$rollname	  n,
	v$rollstat	  s
where
	r.segment_name = n.name
        and
	n.usn = s.usn;
