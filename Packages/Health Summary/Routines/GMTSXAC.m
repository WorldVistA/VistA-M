GMTSXAC ; SLC/KER - List Parameters/Compile Method        ; 02/27/2002
 ;;2.7;Health Summary;**47,49**;Oct 20, 1995
 Q
 ;                        
 ; External References
 ;                        
 ;   None
 ;                        
 ; This routine expects:
 ;                                 
 ;   GMTSUSR    Pointer to User
 ;                        
EN ; Main Entry
 N GMTSG D CPL,SH Q
EN1 ; Display Compile Method - Single ? Help
 N GMTSG S GMTSG=1 D CPLH Q
EN2 ; Display Compile Method - Double ?? Help
 N GMTSG S GMTSG=1 D CPL Q
EN3 ; Display Preferred Compile Method
 N GMTSG D CPL Q
 ;                                      
CPL ; Compile Method
 N GMTSPRE,GMTSCPL,GMTSCPA,GMTSCPI,GMTSM,GMTSALW,GMTSU,GMTSO D EN^GMTSXAW
 S (GMTSO,GMTSU)=+($G(GMTSUSR)) S:+GMTSU=0 GMTSU=+($G(DUZ)) N GMTSUSR S GMTSUSR=GMTSU
 S GMTSPRE=$$PRE^GMTSXAL(+($G(GMTSUSR))),GMTSM=$L(GMTSPRE,";") Q:'$L(GMTSPRE)
 S GMTSCPL=$$CPL^GMTSXAL(+($G(GMTSUSR)))
 S:(+($G(GMTSO))=.5)&('$L(GMTSCPL)) GMTSCPL=1
 I +($G(GMTSG))'>0 D:+GMTSCPL>0 CPLA D:+GMTSCPL'>0 CPLO D BL
 I +($G(GMTSG))>0 D CPLH,BL,CPLA,BL,TL("   OR ---"),BL,CPLO
 Q
CPLH ;   Compile Help - Header
 D TL("   Health Summary Types may be added to CPRS reports tab by either appending")
 D TL("   them to the list or by overwriting existing Health Summaries on the list.") Q
CPLA ;   Compile = Append
 N GMTSI,GMTSC,GMTSH,GMTSN,GMTSE,GMTSA,GMTST,GMTSP,GMTSL,GMTSM
 S GMTSP=$G(GMTSPRE) Q:$L(GMTSP,";")'>1  S (GMTSC,GMTSL)=0,GMTSM="A"
 S:+($G(GMTSO))=.5 GMTSP=$$DEF^GMTSXAW
 F GMTSI=1:1 S GMTST=$P($G(GMTSP),";",GMTSI) Q:'$L(GMTST)  D
 . S:$P($G(GMTSP),";",(GMTSI+1))="" GMTSL=1
 . I GMTST="NAT" S GMTSC=GMTSC+1,GMTSN="National",GMTSA=GMTST D:GMTSC=1&(+($G(GMTSG))'>0) CPLT D CPLP Q
 . S GMTSE=+($O(GMTSALW("B",GMTST,0))) Q:+GMTSE=0  S GMTSE=$G(GMTSALW(+GMTSE))
 . S GMTSA=$P(GMTSE,"^",1) Q:'$L(GMTSA)  S GMTSN=$P(GMTSE,"^",4) Q:'$L(GMTSN)  S GMTSC=GMTSC+1 D:GMTSC=1&(+($G(GMTSG))'>0) CPLT D CPLP
 Q
CPLO ;   Compile = Overwrite
 N GMTSI,GMTSC,GMTSH,GMTSN,GMTSE,GMTSA,GMTST,GMTSP,GMTSL,GMTSM,GMTSNAT S GMTSP=$G(GMTSPRE) Q:$L(GMTSP,";")'>1  S (GMTSNAT,GMTSL,GMTSC)=0,GMTSM="O"
 S:+($G(GMTSO))=.5 GMTSP=$$DEF^GMTSXAW
 F GMTSI=$L(GMTSP,";"):-1 S GMTST=$P($G(GMTSP),";",GMTSI) Q:'$L(GMTST)  Q:GMTSI=0  D
 . S:$P($G(GMTSP),";",(GMTSI-1))="" GMTSL=1 S:GMTSI-1=0 GMTSL=1 I GMTST="NAT" S GMTSNAT=1 Q
 . S GMTSE=+($O(GMTSALW("B",GMTST,0))) Q:+GMTSE=0  S GMTSE=$G(GMTSALW(+GMTSE))
 . S GMTSA=$P(GMTSE,"^",1) Q:'$L(GMTSA)  S GMTSN=$P(GMTSE,"^",4) Q:'$L(GMTSN)
 . S GMTSC=GMTSC+1 D:GMTSC=1&(+($G(GMTSG))'>0) CPLT D CPLP
 I +GMTSNAT>0 S GMTSC=+($G(GMTSC))+1,GMTSN="National",(GMTSA,GMTST)="NAT" D:GMTSC=1&(+($G(GMTSG))'>0) CPLT D CPLP
 D:$G(GMTSP)["NAT" INDP
 Q
CPLP ;   Compile Parameter
 Q:'$L($G(GMTST))  Q:'$L($G(GMTSN))  Q:'$L($G(GMTSA))  Q:'$L(GMTSM)
 N GMTSP S:GMTSM="A" GMTSH=$S(+($G(GMTSC))=1:"Add",1:"Append with") S:GMTSM="O" GMTSH=$S(+($G(GMTSC))=1:"Add",1:"Overwrite with")
 S GMTSL=+($G(GMTSL)) S:GMTST="NAT"&(GMTSC>1) GMTSH="Add" S:GMTST'="NAT" GMTSP="     "_GMTSH_" "_GMTSN_" Defined Summary Types" S:GMTST="NAT" GMTSP="     "_GMTSH_" National Defined Summary Types"
 S:+($G(GMTSC))>1 GMTSP=GMTSP_" (if found)" S:+($G(GMTSC))=1 GMTSP=GMTSP_" to the list" S:+GMTSL'>0 GMTSP=GMTSP_", then" D TL(GMTSP)
 Q
CPLT ;   Compile Title
 D BL,TL(" Method for building the List:    "),AL(($S(+($G(GMTSCPL))'>0:"Overwrite",1:"Append"))),BL Q
INDP ;   Independent Types
 N GMTSI,GMTSPA,GMTSPT,GMTSPI,GMTSPE,GMTSMSG,GMTSX,GMTST,GMTSL,GMTSR,GMTSS,GMTSN
 S GMTSN="       ",GMTSPT=$$DEF^GMTSXAW
 F GMTSI=1:1 S GMTSPA=$P(GMTSPT,";",GMTSI) Q:'$L(GMTSPA)  D
 . S GMTSPI=$$ETI^GMTSXAW3(GMTSPA),GMTSPE=$$EMC^GMTSXAW3(+($G(GMTSPI))),GMTSX=$G(GMTSX)_", "_GMTSPE
 S:$E(GMTSX,1,2)=", " GMTSX=$E(GMTSX,3,$L(GMTSX)) S:$L(GMTSX,", ")>1 GMTSX=$P(GMTSX,", ",1,($L(GMTSX,", ")-1))_" and "_$P(GMTSX,", ",$L(GMTSX,", "))
 S GMTST="National Health Summary Types are added to the list",GMTSL=$L(GMTST),GMTST="Note:  "_GMTST,GMTST=GMTSN_GMTST D BL,TL(GMTST)
 S GMTSN=GMTSN_"       ",GMTST="independently of "_$S($L(GMTSX):GMTSX,1:"other")_" defined types, and placed on the list in the order specified by the precedence."
 D INDPT
 Q
INDPT ;   Independent Types (text)
 I $L(GMTST)'>GMTSL S GMTST=GMTSN_GMTST D TL(GMTST) Q
 F  Q:'$L(GMTST)  D INDPL
 Q
INDPL ;   Independent Types (long text)
 I $L(GMTST)'>GMTSL D TL((GMTSN_GMTST)) S GMTST="" Q
 N GMTSREM,GMTSSTO,GMTSI F GMTSI=1:1 Q:$L($P(GMTST," ",1,GMTSI))>GMTSL  Q:'$L($P(GMTST," ",GMTSI))
 S GMTSSTO=$$TRIM^GMTSXA($P(GMTST," ",1,(GMTSI-1))," "),GMTSREM=$$TRIM^GMTSXA($P(GMTST," ",GMTSI,299)," ")
 D:$L(GMTSSTO) TL((GMTSN_GMTSSTO)) S GMTST=GMTSREM
 Q
 ;                               
 ; Miscellaneous
SH ;   Show ^TMP Global
 N GMTSN,GMTSC,GMTSW S GMTSN="^TMP(""GMTSXAD"","_$J_",0)",GMTSC="^TMP(""GMTSXAD"","_$J_",",GMTSW="^TMP(""GMTSXAD"","_$J_",0)"
 F  S GMTSN=$Q(@GMTSN) Q:GMTSN=""!(GMTSN'[GMTSC)  W:GMTSN'[GMTSW !,@GMTSN
 K ^TMP("GMTSXAD",$J)
 Q
BL ;   Blank Line
 D TL("") Q
TL(X) ;   Text Line
 I +($G(GMTSG))>0 W !,$G(X) Q
 N GMTSC S X=$G(X),GMTSC=+($G(^TMP("GMTSXAD",$J,0))),GMTSC=GMTSC+1,^TMP("GMTSXAD",$J,GMTSC,0)=X,^TMP("GMTSXAD",$J,0)=GMTSC Q
AL(X) ;   Append Line
 I +($G(GMTSG))>0 W $G(X) Q
 N GMTSC S X=$G(X),GMTSC=+($G(^TMP("GMTSXAD",$J,0))),^TMP("GMTSXAD",$J,GMTSC,0)=$G(^TMP("GMTSXAD",$J,GMTSC,0))_X,^TMP("GMTSXAD",$J,0)=GMTSC Q
