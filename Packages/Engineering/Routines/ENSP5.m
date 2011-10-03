ENSP5 ;(WASH ISC)/WDS@Charleston-Facility Management Data Export ;4-23-92
V ;;7.0;ENGINEERING;;Aug 17, 1993
 ;
 ;Present data in CSV format for capture by PC for spreadsheet
EN I '$D(^DOSV(0,$I)) S %=2 W !!,"No Data, You must allow the print option to finish." H 2 Q
 Q
 ;
SER ;Service Report; with count of rooms and total net sf per service
 W !!!,"Report sorted by Service is Requested"
 D MSG,WAIT,SET^ENSP G:X=U EXIT1 S ENLT="SER",%=1,BY="+1.5",FLDS="+4.5",IOP="HOME" D PRINT^ENSP G LST
FUNC ;Function Report; with room count and total nsf per function
 W !!!,"Report sorted by Function is requested"
 D MSG,WAIT,SET^ENSP G:X=U EXIT1 S ENLT="FUNC",%=1,BY="+2.6",FLDS="+4.5",IOP="HOME" D PRINT^ENSP G LST
RCS ;RCS 14-4 Report; sorted by RCS=YES and by Service
 W !!!,"Report by RCS 14-4 Services is requested"
 D MSG,WAIT,SET^ENSP G:X=U EXIT1 S ENLT="RCS",%=1,BY="16,+1.5",FR="YES,?",TO="YESZ,?",FLDS="+4.5",IOP="HOME" D PRINT^ENSP G LST
 ;
LST D EN I $D(%) G:%=2 EXIT1
LST1 W !!!,"Ready to list Spreadsheet data in Comma Separated Value (CSV) format.",!!,"Turn on your ASCII file capture feature and save an MS-DOS file with an",!,"extension of CSV, ie. ASCII file name = ________.CSV"
 W !!,"At the end of the data listing, Turn off your ASCII file capture feature",!,"and then open the CSV file in your spreadsheet program to produce graphs."
 W !!,"NOTE:  The last cell of your spreadsheet will contain extraneous text.",!,?7,"You'll probably want to delete it."
 D WAIT G:$E(X)=U EXIT1
 W !,"Facility Management Data",!,$P($T(@ENLT),";",2),!,"Net Square Foot and Room Count Report",!
TLT W:$D(^DOSV(0,$I,"BY")) !,$P(^DOSV(0,$I,"BY",1),"^",3)_",COUNT,NET SQUARE FT.",!
LOOP S N=0
 F J=0:0 S N=$O(^DOSV(0,$I,1,N)) Q:N=""  D LOOP1
EXIT W !,"Turn off data capture, Press <RETURN> when ready. " R X:DTIME
 G:X'=U MSG1
EXIT1 K %,J,ENLT,N,^DOSV(0,$I) Q
LOOP1 W """"_N_""","_^DOSV(0,$I,1,N,1,"N")_","_^("S"),!
 Q
MSG W !!,"I must do a FileMan sort to organize the data you want to export. The data will",!,"Print in FileMan format on your screen. At the end of the print you will be",!,"instructed on how to capture the data you have requested.",!
 W !,"No Device Selection will be asked. This option cannot be queued.",! Q
MSG1 W !!!,"I still have this data stored and can list it for capture again without",!,"re-running the FileMan sort in case you missed it the first time.",!!,"Want to list the data again " S %=2 D YN^DICN G:%=1 LST G:%=0 MSG1
 G EXIT1
 ;
WAIT W !!!!,"Press <RETURN> when ready, or '^' to escape. " R X:DTIME Q
 ;ENSP5
