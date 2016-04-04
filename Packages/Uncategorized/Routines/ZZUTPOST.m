%utPOST ;VEN-SMH/JLI - post install for M-Unit Test software ;12/16/15  08:58
 ;;1.3;MASH UTILITIES;;DEC 16,2015;Build 4
 ; Submitted to OSEHRA DEC 16, 2015 by Joel L. Ivey under the Apache 2 license (http://www.apache.org/licenses/LICENSE-2.0.html)
 ; Original routine authored by Sam H. Habiel 07/2013-04/2014
 ; Additions and modifications made by Joel L. Ivey 05/2014-08/2015
 ;
 N X,I
 I +$SY=47 D  R X:$G(DTIME,300) D MES^XPDUTL(" ")
 . S X(1)=" "
 . S X(2)="In the next section, as it tries to copy the ut* routines"
 . S X(3)="to %ut* routines watch for text that indicates the following:"
 . S X(4)=" "
 . S X(5)="cp: cannot create regular file `/_ut.m': Permission denied"
 . S X(6)=" "
 . S X(7)="If this is seen, respond Yes at the prompt after the attempt:"
 . S X(8)="   Press ENTER to continue: "
 . F I=1:1:18 D MES^XPDUTL(" ") ; create a blank screen for text
 . D MES^XPDUTL(.X)
 . Q
 D RENAME
 I +$SY=47 D  R X:$G(DTIME,300) I "Yy"[$E($G(X)) D GTMPROB
 . K X
 . S X(1)=" "
 . S X(2)="  Your entry on the next line may not echo"
 . S X(3)="If error text was seen enter Y (and RETURN):  NO// "
 . D MES^XPDUTL(.X)
 . Q
 Q
 ;
RENAME ;
 N %S,%D ; Source, destination
 S U="^"
 S %S="ut^ut1^utcover^utt1^utt2^utt3^utt4^utt5^utt6^uttcovr"
 S %D="%ut^%ut1^%utcover^%utt1^%utt2^%utt3^%utt4^%utt5^%utt6^%uttcovr"
 ;
MOVE ; rename % routines
 N %,X,Y,M
 F %=1:1:$L(%D,"^") D  D MES(M) I +$SY=47 D MES(" ")
 . S M="",X=$P(%S,U,%) ; from
 . S Y=$P(%D,U,%) ; to
 . Q:X=""
 . S M="Routine: "_$J(X,8)
 . Q:Y=""  I $T(^@X)=""  S M=M_"  Missing" Q
 . S M=M_" Loaded, "
 . D COPY(X,Y)
 . S M=M_"Saved as "_$J(Y,8)
 ;
 QUIT  ; END
 ;
COPY(FROM,TO) ;
 N XVAL
 I +$SYSTEM=0 S XVAL="ZL @FROM ZS @TO" X XVAL QUIT
 I +$SYSTEM=47 DO  QUIT
 . S FROM=$$PATH(FROM)
 . S TO=$$PATH(TO,"WRITE")
 . N CMD S CMD="cp "_FROM_" "_TO
 . O "cp":(shell="/bin/sh":command=CMD:WRITEONLY)::"PIPE"
 . U "cp" C "cp"
 QUIT
 ;
PATH(ROUTINE,MODE) ; for GT.M return source file with path for a routine
 ;input: ROUTINE=Name of routine
 ;       MODE="READ" or "WRITE" defaults to READ
 ;output: Full filename
 ;
 S MODE=$G(MODE,"READ") ;set MODE to default value
 N FILE S FILE=$TR(ROUTINE,"%","_")_".m" ;convert rtn name to filename
 N ZRO S ZRO=$ZRO
 ;
 ; Get source routine
 N %ZR
 I MODE="READ" D SILENT^%RSEL(ROUTINE,"SRC") Q %ZR(ROUTINE)_FILE
 ;
 ; We are writing. Parse directories and get 1st routine directory
 N DIRS
 D PARSEZRO(.DIRS,ZRO)
 N PATH S PATH=$$ZRO1ST(.DIRS)
 ;
 QUIT PATH_FILE ;end of PATH return directory and filename
 ;
 ;
PARSEZRO(DIRS,ZRO) ; Parse $zroutines properly into an array
 N PIECE
 N I
 F I=1:1:$L(ZRO," ") S PIECE(I)=$P(ZRO," ",I)
 N CNT S CNT=1
 F I=0:0 S I=$O(PIECE(I)) Q:'I  D
 . S DIRS(CNT)=$G(DIRS(CNT))_PIECE(I)
 . I DIRS(CNT)["("&(DIRS(CNT)[")") S CNT=CNT+1 QUIT
 . I DIRS(CNT)'["("&(DIRS(CNT)'[")") S CNT=CNT+1 QUIT
 . S DIRS(CNT)=DIRS(CNT)_" " ; prep for next piece
 QUIT
 ;
ZRO1ST(DIRS) ; $$ Get first routine directory
 N OUT ; $$ return
 N %1 S %1=DIRS(1) ; 1st directory
 ; Parse with (...)
 I %1["(" DO
 . S OUT=$P(%1,"(",2)
 . I OUT[" " S OUT=$P(OUT," ")
 . E  S OUT=$P(OUT,")")
 ; no parens
 E  S OUT=%1
 ;
 ; Add trailing slash
 I $E(OUT,$L(OUT))'="/" S OUT=OUT_"/"
 QUIT OUT
 ;
MES(T,B) ;Write message.
 S B=$G(B)
 I $L($T(BMES^XPDUTL)) D BMES^XPDUTL(T):B,MES^XPDUTL(T):'B Q
 W:B ! W !,T
 Q
 ;
TEST ; @TEST - TESTING TESTING
 ;
 N ZR S ZR="o(p r) /var/abc(/var/abc/r/) /abc/def $gtm_dist/libgtmutl.so vista.so"
 N DIRS D PARSEZRO(.DIRS,ZR)
 N FIRSTDIR S FIRSTDIR=$$ZRO1ST(.DIRS)
 I FIRSTDIR'="p" S $EC=",U1,"
 ;
 N ZR S ZR="/var/abc(/var/abc/r/) o(p r) /abc/def $gtm_dist/libgtmutl.so vista.so"
 N DIRS D PARSEZRO(.DIRS,ZR)
 N FIRSTDIR S FIRSTDIR=$$ZRO1ST(.DIRS)
 I FIRSTDIR'="/var/abc/r/" S $EC=",U1,"
 ;
 N ZR S ZR="/abc/def /var/abc(/var/abc/r/) o(p r) $gtm_dist/libgtmutl.so vista.so"
 N DIRS D PARSEZRO(.DIRS,ZR)
 N FIRSTDIR S FIRSTDIR=$$ZRO1ST(.DIRS)
 I FIRSTDIR'="/abc/def" S $EC=",U1,"
 ;
 WRITE "All tests have run successfully!",!
 QUIT
 ;
GTMPROB ; come here in case of error trying to run unit tests - checks whether renaming worked
 N X
 S X(1)=" "
 S X(2)="*** An error occurred during renaming of routines to %ut*."
 S X(3)="*** The renaming has been seen to fail on one type of Linux system."
 S X(4)="*** In this case, at the Linux command line copy each ut*.m routine"
 S X(5)="*** (ut.m, ut1.m, utt1.m, utt2.m, utt3.m, utt4.m, utt5.m, utt6.m, and "
 S X(6)="*** uttcovr.m) to _ut*.m (e.g., 'cp ut.m _ut.m', 'cp ut1.m _ut1.m',"
 S X(7)="*** 'cp utt1.m _utt1.m', etc., to 'cp uttcovr.m _uttcovr.m').  Then in GT.M"
 S X(8)="*** use the command 'ZLINK %ut', then 'ZLINK %ut1', etc., these may"
 S X(9)="*** indicate an undefined local variable error, but continue doing it."
 S X(10)="*** When complete, use the M command 'DO ^%utt1' to run the unit tests on"
 S X(11)="*** the %ut and %ut1 routines to confirm they are working"
 S X(12)=" "
 S X(13)="  Press Enter to continue: "
 D MES^XPDUTL(.X)
 R X:$G(DTIME,300)
 Q
