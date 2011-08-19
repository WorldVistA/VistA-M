RMPRPIUG ;HINCIO/ODJ - CONVERT OLD PIP TO NEW PIP ;7/30/02  08:19
 ;;3.0;PROSTHETICS;**61**;Feb 09, 1996
 Q
 ;
 ;***** CONV - Convert old PIP files to the new design (start)
 ;             Should be run as post init in patch 61
 ;             No re-start allowed and all Prosthetic Inventory
 ;             menu options including Stock Issue and quick edit
 ;             should be disabled.
 ;             If conversion needs to be re-run then you must call
 ;             KILL^RMPRPIXZ before running this utility.
 ;
CONV I $D(^RMPR(661.5,"B")) D  G CONVX ;don't convert if 661.5 has a rec
 . I '$D(IO("Q")) D
 .. W !!
 .. W "** File 661.5 already exists, aborting conversion, please log NOIS"
 .. Q
 . Q
DUZ S RMPRDUZ=$$GETUSR^RMPRPIU0(DUZ)
 I RMPRDUZ="" D  G CONVX ;need valid DUZ
 . I '$D(IO("Q")) D
 .. W !!
 .. W "** Need valid DUZ variable set"
 .. Q
 . Q
 I '$D(IO("Q")) D
 . W !,"PIP Old to New file conversion starting."
 . Q
 K ^TMP($J)
 D LOCN^RMPRPIUJ ; create locations (old to new map in ^TMP($J,"LOCN")
 D CONV^RMPRPIUI ; create commercial items that exist in 661.3
 D CONV1A        ; create current inventory (from 661.3)
 D CONV^RMPRPIUH ; create issues (from 660 and 661.2)
 D REC^RMPRPIUK  ; create initial balancing reconciliations
 D BAL^RMPRPIUK  ; create balance history (661.9)
 D UNIT^RMPRPIUJ  ; update unit of issue (661.7)
 K ^TMP($J)
RENDX S DIK="^RMPR(661.11," D IXALL^DIK
 I '$D(IO("Q")) D
 . W !,"PIP Old to New file conversion complete.",!
 . Q
CONVX Q
 ;
 ; Convert current inventory based on file 661.3
 ; Main Loop on location
CONV1A N RMPRL,RMPRHREC,RMPRERR,RMPR5,RMPRI,RMPRREC,RMPRITM,X,Y,DA,RMPRSS
 N RMPRH,RMPRHIEN,RMPR4,RMPR6,RMPR,RMPR11,RMPRSRC,RMPRTODT,RMPR41
 I '$D(IO("Q")) D
 . W !,"Creating Current Inventory - file 661.7 "
 . Q
 D NOW^%DTC S RMPRTODT=$P(%,".",1)
 S RMPRL=0
CONV1 S RMPRL=$O(^RMPR(661.3,RMPRL))
 I '+RMPRL G CONV1AX
 I '$D(^TMP($J,"LOCN",RMPRL)) G CONV1
 S RMPR5("IEN")=^TMP($J,"LOCN",RMPRL)
 S RMPRREC=^RMPR(661.3,RMPRL,0)
 S RMPR5("STATION")=$P(RMPRREC,"^",3)
 ;
 ; Loop on the HCPCS node in 661.3
 K ^TMP($J,"H")
 S RMPRH=0
CONV2 S RMPRH=$O(^RMPR(661.3,RMPRL,1,RMPRH))
 I '$D(IO("Q")) D
 . W:$X=79 ! W "."
 . Q
 I '+RMPRH D  G CONV1
 . D TMPH(.RMPR5)
 . K ^TMP($J,"H")
 . Q
 S RMPRREC=$G(^RMPR(661.3,RMPRL,1,RMPRH,0))
 S RMPRHIEN=$P(RMPRREC,"^",1) ;ien to 661.1
 I RMPRHIEN="" G CONV2 ;ignore if null 661.1 ptr
 I '$D(^RMPR(661.1,RMPRHIEN,0)) G CONV2 ;ignore if bad ptr
 S RMPRHREC=^RMPR(661.1,RMPRHIEN,0)
 K RMPR11
 S RMPR11("STATION")=RMPR5("STATION")
 S RMPR11("STATION IEN")=RMPR5("STATION")
 S RMPR11("HCPCS")=$P(RMPRHREC,"^",1) ;get HCPCS code from 661.1
 I RMPR11("HCPCS")="" G CONV2 ;ignore if null HCPCS code
 ;
 ; Loop on HCPCS Item node in 661.3
 S RMPRI=0
CONV3 S RMPRI=$O(^RMPR(661.3,RMPRL,1,RMPRH,1,RMPRI))
 I '+RMPRI G CONV2
 S RMPRREC=$G(^RMPR(661.3,RMPRL,1,RMPRH,1,RMPRI,0))
 I $P($P(RMPRREC,"^",1),"-",1)'=RMPR11("HCPCS") G CONV3 ;bad HCPCS
 S RMPR11("SOURCE")="C"
 I $P(RMPRREC,"^",9)="V" S RMPR11("SOURCE")="V"
 S RMPRITM=$P($P(RMPRREC,"^",1),"-",2)
 I RMPRITM="" G CONV3
 S RMPR11("UNIT")=$P(RMPRREC,"^",4)
 S RMPR7("UNIT")=$P(RMPRREC,"^",4)
 K RMPR6
 S RMPR6("QUANTITY")=+$P(RMPRREC,"^",2)
 S RMPR6("VALUE")=+$P(RMPRREC,"^",3)
 S RMPR6("VALUE")=$J(RMPR6("VALUE"),0,2)
 S RMPR6("VENDOR IEN")=$P(RMPRREC,"^",5)
 K RMPR4
 S RMPR4("RE-ORDER QTY")=+$P(RMPRREC,"^",6)
 K RMPR41
 S RMPR41("ORDER QTY")=+$P(RMPRREC,"^",11)
 D GETITM^RMPRPIUH(.RMPR11,RMPRHIEN,RMPRITM)
 ;
 ; Create HCPCS Item Re-Order record 661.4
 I '$D(^RMPR(661.4,"ASLHI",RMPR11("STATION IEN"),RMPR5("IEN"),RMPR11("HCPCS"),RMPR11("ITEM"))) D
 . S RMPRERR=$$CRE^RMPRPIX4(.RMPR4,.RMPR11,.RMPR5)
 . Q
 ;
 ; Save in Temp global for later update
 I RMPR6("VENDOR IEN")="" G CONV3
 I $D(^TMP($J,"H",RMPR11("HCPCS"),RMPR11("ITEM"),RMPR6("VENDOR IEN"))) D
 . S RMPRSS=^TMP($J,"H",RMPR11("HCPCS"),RMPR11("ITEM"),RMPR6("VENDOR IEN"))
 . S $P(RMPRSS,"^",1)=$P(RMPRSS,"^",1)+RMPR6("QUANTITY")
 . S $P(RMPRSS,"^",2)=$P(RMPRSS,"^",2)+RMPR6("VALUE")
 . Q
 E  D
 . S RMPRSS=RMPR6("QUANTITY")
 . S $P(RMPRSS,"^",2)=RMPR6("VALUE")
 . Q
 S RMPRSS=RMPRSS_U_$G(RMPR11("UNIT"))
 S ^TMP($J,"H",RMPR11("HCPCS"),RMPR11("ITEM"),RMPR6("VENDOR IEN"))=RMPRSS
 ;
 ; If there is an order quantity then save it to file 661.41
 I RMPR41("ORDER QTY")>0 D
 . S RMPR41("VENDOR")=RMPR6("VENDOR IEN")
 . S RMPR41("DATE ORDER")=RMPRTODT
 . S RMPR41("STATUS")="O"
 . S RMPRERR=$$CRE^RMPRPIXN(.RMPR41,.RMPR11)
 . Q
 G CONV3 ;next item in 661.3
 ;
 ; Process the ^TMP($J,"H") global just created
TMPH(RMPR5) ;
 N RMPRH,RMPRI,RMPRV,RMPR,RMPR11,RMPRERR,RMPRSS,RMPR6,RMPRUCST
 S RMPRH=""
 F  S RMPRH=$O(^TMP($J,"H",RMPRH)) Q:RMPRH=""  D
 . S RMPRI=""
 . F  S RMPRI=$O(^TMP($J,"H",RMPRH,RMPRI)) Q:RMPRI=""  D
 .. S RMPRV=""
 .. F  S RMPRV=$O(^TMP($J,"H",RMPRH,RMPRI,RMPRV)) Q:RMPRV=""  D
 ... S RMPRSS=^TMP($J,"H",RMPRH,RMPRI,RMPRV)
 ... K RMPR6
 ... S RMPR6("QUANTITY")=+$P(RMPRSS,"^",1)
 ... S RMPR6("VALUE")=+$P(RMPRSS,"^",2)
 ... S RMPR6("UNIT")=+$P(RMPRSS,"^",3)
 ... S RMPR6("VENDOR IEN")=RMPRV
 ... K RMPR11
 ... S RMPR11("STATION")=RMPR5("STATION")
 ... S RMPR11("STATION IEN")=RMPR5("STATION")
 ... S RMPR11("HCPCS")=RMPRH
 ... S RMPR11("ITEM")=RMPRI
 ... S RMPR11("UNIT")=$P(RMPRSS,U,3)
 ... ;
 ... ; If quantity<0 then create a reconciliation gain
 ... ; of the amount followed by a 0 reconciliation
 ... I RMPR6("QUANTITY")<0 D
 .... K RMPR
 .... S RMPR("QUANTITY")=0-RMPR6("QUANTITY")
 .... S RMPR("VALUE")=$S(RMPR6("VALUE")<0:0-RMPR6("VALUE"),1:RMPR6("VALUE"))
 .... S RMPR("NEW UNIT COST")=$J(RMPR("VALUE")/RMPR("QUANTITY"),0,2)
 .... S RMPRUCST=RMPR("NEW UNIT COST")
 .... S RMPR("VENDOR IEN")=RMPR6("VENDOR IEN")
 .... S RMPRERR=$$REC^RMPRPIU9(.RMPR,.RMPR11,.RMPR5)
 .... K RMPR
 .... S RMPR("QUANTITY")=0
 .... S RMPR("VENDOR IEN")=RMPR6("VENDOR IEN")
 .... S RMPR("NEW UNIT COST")=RMPRUCST
 .... S RMPRERR=$$REC^RMPRPIU9(.RMPR,.RMPR11,.RMPR5)
 .... Q
 ... ;
 ... ; If +VE qty. just record as a gain
 ... E  D
 .... S:RMPR6("VALUE")<0 RMPR6("VALUE")=0-RMPR6("VALUE")
 .... S RMPR6("NEW UNIT COST")=0
 .... S:RMPR6("QUANTITY") RMPR6("NEW UNIT COST")=$J(RMPR6("VALUE")/RMPR6("QUANTITY"),0,2)
 .... S RMPRERR=$$REC^RMPRPIU9(.RMPR6,.RMPR11,.RMPR5)
 .... Q
 ... Q
 .. Q
 . Q
TMPHX K ^TMP($J,"H")
 Q
 ;
 ;exit
CONV1AX K ^TMP($J,"H")
 Q
