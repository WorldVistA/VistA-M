IBDFBKS1 ;ALB/CJM/AAS - ENCOUNTER FORM - create form spec for scanning (Broker Version CONTINUATION) ; 6-JUN-95
 ;;3.0;AUTOMATED INFO COLLECTION SYS;**3,25**;APR 24, 1997
 ;
 ;
FORM ;;
 ;;'Paper Keyboard FormSpec
 ;;'VERSION = 2.53
 ;;'AICS Version 3.0;**7,3,25**
SITE ;;'VA SITE NAME
 ;;INT anchorcnt;
 ;;INT hasprint;
 ;;INT check;
 ;;INT firstanchor;
 ;;INT pfid;
 ;;INT page;
 ;;INT saveunrf;
 ;;INT ddechan;
 ;;ALPHA narrative;
 ;;
 ;;FORM
NAME ;;  NAME = "ENCOUNTER FORM 71";
 ;;  AREA =  0 0 2770 2150;
 ;;  PAGESIZE = " 2770 2150";
 ;;  ANCHOR1 = NONE;
 ;;  ANCHOR2 = NONE;
 ;;  POINTS = 0 0 0 0;
 ;;  CONFIDENCE = " 9";
 ;;  CLOSEFORMSPEC = {DDETERM(ddechan);
 ;;     LOG(\"AICS #52/DDE channel is closed\"); };
 ;;  DATEFORMAT = "6";
 ;;  TIMEFORMAT = "5";
 ;;  EXFORMAT = "STRIP";
 ;;  EXPORT = "\'SHOW(\"DO NOT EXPORT - NOT SCANNABLE\");";
 ;;  FS = ",";
 ;;  QUOTABLE = "\\n";
 ;;  ImageProcessing = {
 ;;     IMAGEPROC=1
 ;;     AUTO_ALIGN=0
 ;;     ALIGN_TEXT=0
 ;;     ALIGN_ORIENT=0
 ;;     DESKEW=0
 ;;     DESHADE=0
 ;;     SMOOTH=0
 ;;     REMOVE_BORDER=1
 ;;     REMOVE_NOISE=0
 ;;     PROC_MIN_VERT_LINE_LEN=0
 ;;     PROC_MIN_HORZ_LINE_LEN=0
 ;;     FATTYPE=0
 ;;     FATTEN=0};
 ;;  POSITION = "60,60";
 ;;  OPENFORMSPEC = {ddechan=DDEINIT(\"IBDSCAN\",\"DdeServerConv\");
 ;;     if (ddechan == 0) LOG(\"AICS #54/Unable to Open Channel to AICS.\");
 ;;     \' if (ddechan == 0) SHOW(\"Unable to Open Channel to AICS to send data.\");
 ;;     anchorcnt = 4;
 ;;     }; 
 ;;FIELD ' 1
 ;;  NAME = "TOP LEFT ANCHOR";
 ;;  ELEMTYPE = ELEM_PAT;
 ;;  METRIC = 17 120 120;
 ;;  DATATYPE =INT;
 ;;  LENGTH = 2;
 ;;  POINTS = 65 70 120 130;
 ;;  PAGE = 0;
 ;;  CONFIDENCE = " 6";
 ;;  HIDDEN = "1";
 ;;  END = {if (anchorcnt == 2){
 ;;     firstanchor = 1; 
 ;;     if (FIELDSTATUS != FIELD_OK) firstanchor = 0;}
 ;;     };
 ;;  Pattern = "PATTERN=C:\\VISTA\\AICS\\FORMSPEC\\AICSLOGO.BMP";
 ;;  REQUIRED = "1";
 ;;FIELD ' 2
 ;;  NAME = "BOTTOM LEFT ANCHOR";
 ;;  ELEMTYPE = ELEM_PAT;
 ;;  METRIC = 17 120 120;
 ;;  DATATYPE =INT;
 ;;  LENGTH = 2;
 ;;  POINTS = 2690 70 2745 130;
 ;;  PAGE = 0;
 ;;  CONFIDENCE = " 6";
 ;;  HIDDEN = "1";
 ;;  Pattern = "PATTERN=C:\\VISTA\\AICS\\FORMSPEC\\AICSLOGO.BMP";
 ;;  REQUIRED = "1";
 ;;  END = {INT aset;
 ;;    if (anchorcnt == 2){
 ;;       if ((firstanchor == 1) && (FIELDSTATUS == FIELD_OK))
 ;;          aset = ANCHORSET(1,2);
 ;;       else aset = 0;
 ;;       if (aset == 0) {NEXTFIELD = 3;} 
 ;;       else NEXTFIELD = 5;}
 ;;  }; 
 ;;FIELD ' 3
 ;;  NAME = "TOP RIGHT ANCHOR";
 ;;  ELEMTYPE = ELEM_PAT;
 ;;  METRIC = 17 120 120;
 ;;  DATATYPE =INT;
 ;;  LENGTH = 2;
 ;;  POINTS = 65 2015 120 2075;
 ;;  PAGE = 0;
 ;;  CONFIDENCE = " 6";
 ;;  END = {if (anchorcnt == 2) {
 ;;     firstanchor = 1; 
 ;;     if (FIELDSTATUS != FIELD_OK) firstanchor = 0;}
 ;;     };
 ;;  HIDDEN = "1";
 ;;  Pattern = "PATTERN=C:\\VISTA\\AICS\\FORMSPEC\\AICSLOGO.BMP";
 ;;  REQUIRED = "1";
 ;;FIELD ' 4
 ;;  NAME = "BOTTOM RIGHT ANCHOR";
 ;;  ELEMTYPE = ELEM_PAT;
 ;;  METRIC = 17 120 120;
 ;;  DATATYPE =INT;
 ;;  LENGTH = 2;
 ;;  POINTS = 2690 2015 2745 2075;
 ;;  PAGE = 0;
 ;;  CONFIDENCE = " 6";
 ;;  HIDDEN = "1";
 ;;  Pattern = "PATTERN=C:\\VISTA\\AICS\\FORMSPEC\\AICSLOGO.BMP";
 ;;  REQUIRED = "1";
 ;;  END={INT aset;
 ;;INT result;
 ;;  if (anchorcnt == 2){
 ;;     if ((firstanchor == 1) && (FIELDSTATUS == FIELD_OK))     
 ;;     aset = ANCHORSET(3,4);
 ;;     else aset =0;
 ;;     if (aset == 0) {
 ;;        if (ddechan == 0) SHOW(\"Anchors not found, recognition stopping!\");
 ;;        if (ddechan != 0) {
 ;;           result = DDEEXEC(ddechan,\"SAVEFORM(0,0,0,U"\);
 ;;           DDEPOKE(ddechan,\"DdeServerItem\",\"Anchors not found\");}
 ;;        CHAIN(\"C:\\\\vista\\\\aics\\\\formspec\\\\AICSMSTR.FS\",1);}}
 ;;  
 ;;  if (anchorcnt == 4){
 ;;     aset = ANCHORSET(1,4);
 ;;     if (aset == 0) {
 ;;        if (ddechan == 0) SHOW(\"Anchors not found, recognition stopping!\");
 ;;        if (ddechan != 0) {
 ;;           result = DDEEXEC(ddechan,\"SAVEFORM(0,0,0,U"\);
 ;;           DDEPOKE(ddechan,\"DdeServerItem\",\"Anchors not found\");}
 ;;        CHAIN(\"C:\\\\vista\\\\aics\\\\formspec\\\\AICSMSTR.FS\",1);}}
 ;;  };
 ;;FIELD ' 5
 ;;NAME = "SCANPAGE?";
 ;;  ELEMTYPE = ELEM_PAT;
 ;;  METRIC = 17 120 120;
 ;;  DATATYPE =INT;
 ;;  LENGTH = 2;
 ;;  POINTS = 2669 1264 2734 1344;
 ;;  PAGE = 0;
 ;;  CONFIDENCE = " 7";
 ;;  HIDDEN = "1";
 ;;  Pattern = "PATTERN=C:\\VISTA\\AICS\\FORMSPEC\\AICSLOGO.BMP";
 ;;  REQUIRED = "1";
 ;;FIELD ' 6
 ;;  NAME = "FORM ID CHECK";
 ;;  ELEMTYPE = ELEM_OCR;
 ;;  DATATYPE =INT;
 ;;  LENGTH = 3;
 ;;  POINTS = 50 1412 150 1545;
 ;;  PAGE = 0;
 ;;  CHARFORMAT = "NOSPACES";
 ;;  END = {
 ;;  check=GETIVALUE(FIELDNAME);
 ;;  if (check < 1) FIELDSTATUS = FIELD_BAD;
 ;;  if (GETSTATUS(FIELDNAME) == FIELD_BLANK) FIELDSTATUS = FIELD_BAD;};
 ;;  REQUIRED = "1";
 ;;FIELD ' 7
 ;;  NAME = "FORM ID";
 ;;  ELEMTYPE = ELEM_OCR;
 ;;  DATATYPE =INT;
 ;;  LENGTH = 9;
 ;;  POINTS = 50 635 150 910;
 ;;  PAGE = 0;
 ;;  CHARFORMAT = "NOSPACES";
 ;;  END = {
 ;;  INT checksum;
 ;;  INT div;
 ;;
 ;;  pfid=GETIVALUE(FIELDNAME);
 ;;  checksum=3*pfid;
 ;;  div=checksum/997;
 ;;  checksum=checksum-(div*997);
 ;;  if ((checksum!=check)&&(FIELDACCEPTED!=1)) {
 ;;  FIELDSTATUS=FIELD_BAD;
 ;;  }
 ;;};
 ;;FIELD ' 8
 ;;  NAME = "PAGE CHECK";
 ;;  ELEMTYPE = ELEM_OCR;
 ;;  DATATYPE =INT;
 ;;  LENGTH = 3;
 ;;  POINTS = 50 1590 150 1700;
 ;;  PAGE = 0;
 ;;  CHARFORMAT = "NOSPACES";
 ;;  END = {
 ;;  check=GETIVALUE(FIELDNAME);
 ;;  if (check < 1) FIELDSTATUS = FIELD_BAD;
 ;;  if (GETSTATUS(FIELDNAME) == FIELD_BLANK) FIELDSTATUS = FIELD_BAD;};
 ;;  REQUIRED = "1";
 ;;FIELD ' 9
 ;;  NAME = "PAGE";
 ;;  ELEMTYPE = ELEM_OCR;
 ;;  DATATYPE =INT;
 ;;  LENGTH = 1;
 ;;  POINTS = 50 1860 150 1950;
 ;;  PAGE = 0;
 ;;  CHARFORMAT = "NOSPACES";
 ;;  END = {INT  checksum;
 ;;  INT div;
 ;;  ALPHA next;
 ;;
 ;;  page=GETIVALUE(FIELDNAME);
 ;;  next=STRCAT("TOP OF PAGE ",ITOA(page));
 ;;  checksum=3*page;
 ;;  div=checksum/997;
 ;;  checksum=checksum-(div*997);
 ;;
 ;;  if ((checksum!=check)&&(FIELDACCEPTED!=1)) {
 ;;  FIELDSTATUS=FIELD_BAD;
 ;;  }
PGCK ;;  else if ((page!=1)&&(page!=2)){
 ;;  FIELDSTATUS=FIELD_BAD;
 ;;  }
 ;;  else if (page>1) {NEXTFIELD=GETNUM(next); }
 ;;};
QUIT ;;
 ;;
 ;;
TOPOFPG ;;
NUMBER1 ;;FIELD ' 49
FLDNAME ;;  NAME = "TOP OF PAGE 2";
 ;;  ELEMTYPE = RECT;
 ;;  METRIC = 2 2 0 0 0 0 0 0 0;
 ;;  DATATYPE =INT;
 ;;  LENGTH = 1;
 ;;  POINTS = 100 2040;
PAGE1 ;;  PAGE = 1;
 ;;  HIDDEN="1";
 ;;  EXFORMAT="NOEXPORT";
QUIT1 ;;
 ;;
BOTTOM ;;
NUMBER2 ;;FIELD ' 49
NAME2 ;;  NAME = "BOTTOM OF PAGE";
 ;;  ELEMTYPE = RECT;
 ;;  METRIC = 2 2 0 0 0 0 0 0 0;
 ;;  DATATYPE =INT;
 ;;  LENGTH = 1;
 ;;  POINTS = 100 2040;
PAGE2 ;;  PAGE = 1;
 ;;  HIDDEN="1";
 ;;END = {INT result;
 ;;INT loop;
 ;;ALPHA Data;
 ;;ALPHA str;
 ;;ALPHA  RS;
 ;;ALPHA Save;
 ;;ALPHA New;
 ;;ALPHA Add;
 ;;ALPHA End;
 ;;
 ;;if (ddechan == 0) {
 ;;   SHOW(\"AICS is not connected, no data exported!\");
 ;;   CHAIN(\"C:\\\\vista\\\\aics\\\\formspec\\\\AICSMSTR.FS\",1);}
 ;;
 ;;New=\"$$NEW$$("\;
 ;;Add=\"$$ADD$$("\;
 ;;End=\"$$END$$("\;
 ;;RS=STRCAT(",",ITOC(13));
 ;;
 ;;if (BATCH&&(saveunrf>0)){
SAVE ;;  Save = \"SAVEFORM("\;
 ;;  if (ddechan != 0) result = DDEEXEC(ddechan,Save);
 ;;  if (result==0) SHOW(\"Warning: Saving of Unrecognized form in AICS has Failed!\");
 ;;  else DDEPOKE(ddechan,\"DdeServerItem\",\"Operator Verification Needed\");
 ;;  CHAIN(\"C:\\\\vista\\\\aics\\\\formspec\\\\AICSMSTR.FS\",1);}
 ;;
 ;;  if (ddechan != 0) {
EXPORT ;;      \'if (STRFIND(Data,RS,STRLEN(Data) - 1) > 0) {;;      \'    Data = SUBSTR(Data,1,STRLEN(Data) - 1); }
 ;;
 ;;  result=DDEPOKE(ddechan,\"DdeServerItem\",End);}
 ;;CHAIN(\"c:\\\\vista\\\\aics\\\\formspec\\\\AICSMSTR.FS\",1);
 ;;};
 ;;EXFORMAT="NOEXPORT";
QUIT2 ;;
