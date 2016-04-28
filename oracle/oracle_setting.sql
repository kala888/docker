alter profile default limit password_life_time unlimited;
alter system set processes=1001 scope=spfile;
alter system set memory_target=2G;
quit;