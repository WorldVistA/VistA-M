ICDDIC ;ISL/KER - ICD Code Lookup Prototype (DIC) ;04/21/2014
 ;;18.0;DRG Grouper;**57**;Oct 20, 2000;Build 1
 ;               
 ; Global Variables
 ;    None
 ;               
 ; External References
 ;    $$DT^XLFDT          ICR  10103
 ;    $$FMTE^XLFDT        ICR  10103
 ;    ^DIC                ICR  10006
 ;               
 ; Local Variables NEWed or KILLed Elsewhere
 ;     Y
 ;     
EN ; Main Entry Point
 N DIC,DIR,DIROUT,DIRUT,DTOUT,DUOUT,ICD,ICDA,ICDB,ICDC,ICDCOD,ICDCS,ICDCDT,ICDD,ICDD1,ICDD2
 N ICDDP,ICDF,ICDFI,ICDFM,ICDFMT,ICDI,ICDID,ICDINP,ICDK,ICDLONG,ICDMFT,ICDMIX,ICDN
 N ICDO,ICDOA,ICDOUT,ICDPSN,ICDR,ICDS,ICDSHRT,ICDSRC,ICDSY,ICDSYS,ICDT,ICDTD,ICDTY
 N ICDU,ICDV,ICDVAL,ICDVD,ICDVDT,ICDVR,ICD K X,Y
 D EN^ICDDICA W:$D(DTOUT) !!,"   Try later",!
 Q:$D(DTOUT)  W:$D(DUOUT) !!,"   Abort lookup",! Q:$D(DUOUT)  S:+($G(ICDCS))>0 ICDSYS=+($G(ICDCS))
 S ICDFMT=1 S:+($G(ICDFM))>0 ICDFMT=+($G(ICDFM)) S:$G(ICDVD)?7N ICDVDT=$G(ICDVD)
 K:+($G(ICDVR))'>0 ICDVDT S:+($G(ICDFM))>0 ICDMFT=+($G(ICDFM)) S ICDSY=$P(ICDCS,"^",2)
 S ICDTY=$S(+ICDFI=80:"Diagnosis",+ICDFI=80.1:"Procedure",1:"")
 S DIC=$S(ICDDP="D":$$ROOT^ICDEX(80),ICDDP="P":$$ROOT^ICDEX(80.1),1:"")
 W:'$L(DIC) !!,"   Invalid Global Root",!
 Q:'$L(DIC)  S DIC("A")=" Enter an "_ICDSY_" "_ICDTY_":  ",DIC(0)="AEQZ"
 S:'$L($$TM(ICDSY)) DIC("A")=" Enter a "_ICDTY_":  ",DIC(0)="AEQZ"
 S:$L($G(DIC0)) DIC(0)=DIC0 D:$D(ICDSHOW) SHOW K X,Y D ^DIC,OUT N DIC0
 Q
EN2 ; Entry Point that Input Displays Variables
 N ICDSHOW S ICDSHOW="" D EN
 Q
ICD10D ;
 S DIC=$$ROOT^ICDEX(80),DIC("A")=" Enter an ICD-10 Diagnosis:  ",DIC(0)="AEQZ",ICDVDT=3141010,ICDSYS=30
 K X,Y D ^DIC,OUT W !
 Q
ICD10P ;
 S DIC=$$ROOT^ICDEX(80.1),DIC("A")=" Enter an ICD-10 Procedure:  ",DIC(0)="AEQZ",ICDVDT=3141010,ICDSYS=30
 K X,Y D ^DIC,OUT W !
 Q
ICD9D ;
 S DIC=$$ROOT^ICDEX(80),DIC("A")=" Enter an ICD-9 Diagnosis:  ",DIC(0)="AEQZ",ICDVDT=3120101,ICDSYS=1
 K X,Y D ^DIC,OUT W !
 Q
ICD9P ;
 S DIC=$$ROOT^ICDEX(80.1),DIC("A")=" Enter an ICD-10 Procedure:  ",DIC(0)="AEQZ",ICDVDT=3120101,ICDSYS=1
 K X,Y D ^DIC,OUT W !
 Q
OUT ; Output
 N ICDARY,ICDC,ICDCOD,ICDDT,ICDEF,ICDEFF,ICDHIS,ICDI
 N ICDIEN,ICDLON,ICDND,ICDROOT,ICDSHT,ICDST,ICDTDT,ICDX
 S ICDX=$G(X) I +Y'>0,$L($P(Y,"^",2)) D  Q
 . ;W !!,"    ERROR:  ",$P(Y,"^",2),! S X=ICDX
 S ICDIEN=+Y Q:+ICDIEN'>0
 S ICDCOD=$P(Y,"^",2) Q:'$L(ICDCOD)
 S ICDROOT=$$ROOT^ICDEX(+($G(ICDFI))) Q:'$L(ICDROOT)
 S ICDSHT=$P($G(Y(0,1)),"^",4)
 S:'$L(ICDSHT) ICDSHT=$$SD^ICDEX(+($G(ICDFI)),$G(ICDIEN),$P($G(ICDVDT),".",1))
 I '$L(ICDSHT) D
 . N ICDEFF,ICDHIS S ICDEFF=$O(@(ICDROOT_ICDIEN_",67,""B"","" "")"),-1)
 . S ICDHIS=$O(@(ICDROOT_ICDIEN_",67,""B"","_+ICDEFF_","" "")"),-1)
 . S ICDSHT=$G(@(ICDROOT_ICDIEN_",67,"_+ICDHIS_",0)"))
 . S ICDSHT=$P(ICDSHT,"^",2)
 S ICDLON=$G(Y(0,2))
 S:'$L(ICDLON) ICDLON=$$LD^ICDEX(+($G(ICDFI)),$G(ICDIEN),$P($G(ICDVDT),".",1))
 I '$L(ICDLON) D
 . N ICDEFF,ICDHIS S ICDEFF=$O(@(ICDROOT_ICDIEN_",68,""B"","" "")"),-1)
 . S ICDHIS=$O(@(ICDROOT_ICDIEN_",68,""B"","_+ICDEFF_","" "")"),-1)
 . S ICDLON=$G(@(ICDROOT_ICDIEN_",68,"_+ICDHIS_",0)"))
 Q:'$L(ICDSHT)  Q:'$L(ICDLON)
 S ICDARY(1)=ICDLON D PAR^ICDEX(.ICDARY,(78-15))
 W !!,?1,ICDCOD,?15,ICDSHT
 W !!,?1,"Description:",?15,$G(ICDARY(1))
 S ICDI=1 F  S ICDI=$O(ICDARY(ICDI)) Q:+ICDI'>0  W !,?15,$G(ICDARY(ICDI))
 S ICDTDT=$$DT^XLFDT S:$G(ICDVDT)?7N ICDTDT=ICDVDT
 S ICDC=0,ICDEFF=0 F  S ICDEFF=$O(@(ICDROOT_ICDIEN_",66,""B"","""_ICDEFF_""")")) Q:'$L(ICDEFF)  D
 . Q:ICDEFF'?7N  N ICDHIS S ICDHIS=0
 . F  S ICDHIS=$O(@(ICDROOT_ICDIEN_",66,""B"","""_ICDEFF_""","""_ICDHIS_""")")) Q:+ICDHIS'>0  D
 . . N ICDND,ICDST,ICDDT,ICDEDT,ICDP  S ICDND=$G(@(ICDROOT_ICDIEN_",66,"_+ICDHIS_",0)"))
 . . S ICDDT=$P(ICDND,"^",1),ICDST=$P(ICDND,"^",2)
 . . S ICDST=$S(ICDST="1":"Active",ICDST="0":"Inactive",1:"") Q:'$L(ICDST)
 . . S ICDP="" S:ICDTDT?7N&(ICDDT?7N)&(ICDTDT<ICDDT) ICDP=" (Pending)"
 . . S ICDEDT=$$FMTE^XLFDT(ICDDT,"5Z") Q:'$L(ICDEDT)  Q:$L(ICDEDT,"/")'=3  S ICDC=ICDC+1
 . . W:ICDC=1 !!,?1,"History:" W ?15,$G(ICDEDT),?30,ICDST,ICDP,!
 Q
SHOW ; Show Lookup Variables
 W ! W:$L($G(DIC))!($L($G(DIC(0))))!($L($G(DIC("A")))) !," FileMan Variables",!
 W:$L($G(DIC)) !,?2," Global Root/File:",?27,"DIC=""",$$QM($G(DIC)),""""
 W:$L($G(DIC(0))) !,?2," FileMan Response:",?27,"DIC(0)=""",$$QM($G(DIC(0))),""""
 W:$G(DIC(0))["A" !,?35,"A  Ask the entry"
 W:$G(DIC(0))["E" !,?35,"E  Echo information"
 W:$G(DIC(0))["F" !,?35,"F  Forget the lookup value"
 W:$G(DIC(0))["I" !,?35,"I  Ignore the Special Lookup"
 W:$G(DIC(0))["L" !,?35,"L  Not allowed"
 W:$G(DIC(0))["M" !,?35,"M  Multiple-Index"
 W:$G(DIC(0))["N" !,?35,"N  IEN lookup allowed not forced"
 W:$G(DIC(0))["n" !,?35,"n  Partial matching on pure numeric"
 W:$G(DIC(0))["O" !,?35,"O  One exact match"
 W:$G(DIC(0))["Q" !,?35,"Q  Question erroneous input"
 W:$G(DIC(0))["T" !,?35,"T  Continue Searching"
 W:$G(DIC(0))["X" !,?35,"X  Exact match required"
 W:$G(DIC(0))["Z" !,?35,"Z  Zero node returned"
 W:$L($G(DIC("A"))) !,?2," Prompt:",?27,"DIC(""A"")=""",$$QM($G(DIC("A"))),""""
 W:$L($G(ICDSYS))!($L($G(ICDVDT)))!($L($G(ICDFMT))) !!," Special Variables",!
 W:$L($G(ICDSYS)) !,?2," Coding System:",?27,"ICDSYS=""",$$QM($G(ICDSYS)),""""
 W:$L($G(ICDSYS))&($L($G(ICDSY)))&($L($G(ICDTY))) ?45,$G(ICDSY)," ",$G(ICDTY)
 W:$L($G(ICDVDT))&($G(ICDVDT)?7N) !,?2," Versioning Date:",?27,"ICDVDT=""",$$QM($G(ICDVDT)),""""
 W:$L($G(ICDVDT))&($G(ICDVDT)?7N) ?45,$$FMTE^XLFDT($P(ICDVDT,".",1),"5Z")," (No inactive codes)"
 W:'$L($G(ICDVDT)) !,?2," Versioning Date:",?27,"<null>"
 W:'$L($G(ICDVDT)) ?45,"Active and Inactive codes shown"
 I +($G(ICDFMT))>0 D
 . W !,?2," Display Format:",?27,"ICDFMT=""",$$QM($G(ICDFMT)),""""
 . W:+($G(ICDFMT))=1 ?45,"FileMan format, code followed ",!,?45,"by the short description."
 . W:+($G(ICDFMT))=2 ?45,"Modified FileMan format, code ",!,?45,"followed by the long description."
 . W:+($G(ICDFMT))=3 ?45,"Short Lexicon format, short ",!,?45,"description followed by the ",!,?45,"code."
 . W:+($G(ICDFMT))=4 ?45,"Long Lexicon format, Long ",!,?45,"description followed by the ",!,?45,"code."
 Q
QM(X) ;   Quote Marks
 N ICDPSN,ICDOUT,ICDINP S ICDINP=$G(X) Q:'$L(X) ""
 S ICDOUT="" F ICDPSN=1:1:$L(ICDINP,$C(34)) D
 . S ICDOUT=ICDOUT_$C(34)_$C(34)_$P(ICDINP,$C(34),ICDPSN)
 S:$E(ICDOUT,1,2)="""""" ICDOUT=$E(ICDOUT,3,$L(ICDOUT)) S X=ICDOUT
 Q X
TM(X,Y) ; Trim Character Y - Default " "
 S X=$G(X) Q:X="" X  S Y=$G(Y) S:'$L(Y) Y=" " Q:X'[Y X
 F  Q:$E(X,1)'=Y  S X=$E(X,2,$L(X))
 F  Q:$E(X,$L(X))'=Y  S X=$E(X,1,($L(X)-1))
 Q X
