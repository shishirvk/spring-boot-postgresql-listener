-- FUNCTION: public.notify_insert_event()

-- DROP FUNCTION public.notify_insert_event();

CREATE FUNCTION public.notify_insert_event()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE LEAKPROOF 
AS $BODY$DECLARE
    record RECORD;
    payload JSON;
  BEGIN
    IF (TG_OP = 'DELETE') THEN
      record = OLD;
    ELSE
      record = NEW;
    END IF;

    payload = json_build_object('table', TG_TABLE_NAME,
                                'action', TG_OP,
                                'data', row_to_json(record));

    PERFORM pg_notify('insert_events', payload::text);

    RETURN NULL;
  END;$BODY$;

ALTER FUNCTION public.notify_insert_event()
    OWNER TO postgres;
