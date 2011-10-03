LEXDM2 ; ISL Default Misc - Ask to delete         ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; Entry:  S X=$$EN^LEXDM2(USER,AP,DEF)
 ;
 ; Input   
 ;         USER    DUZ
 ;         AP      Application
 ;         DEF     Default (1 thru 4)
 ;
 ; Returns
 ;         0       Do not Delete default
 ;         1       Delete default
 ;
EN(LEXUSER,LEXAP,LEXDEF) ;
 ; A few good reasons to quit
 Q:+($G(LEXUSER))=0 0  Q:'$D(^VA(200,+($G(LEXUSER)))) 0
 Q:+($G(LEXAP))=0 0  Q:'$D(^LEXT(757.2,+($G(LEXAP)))) 0
 Q:+($P($G(^LEXT(757.2,+LEXAP,5)),"^",3))'>0 0
 Q:+($G(LEXDEF))<1!(+($G(LEXDEF))>4) 0
 ; Check for default
 N LEXOV,LEXN S LEXN=""
 S LEXOV=$G(^LEXT(757.2,LEXAP,200,LEXUSER,LEXDEF))
 S LEXN=$G(^LEXT(757.2,LEXAP,200,LEXUSER,(LEXDEF+.5)))
 Q:LEXOV="" 0 D:$L(LEXOV) ASK Q LEXDEF
 ;
ASK ; Ask to delete
 W ! N LEXYPE,DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y S LEXYPE=$S(LEXDEF=1:"filter",LEXDEF=2:"display",LEXDEF=3:"vocabulary",1:"shortcut context")
 I LEXN="" S:LEXDEF=1 LEXN=$$N1(LEXOV) S:LEXDEF=2 LEXN=$$N2(LEXOV) S:LEXDEF=3 LEXN=$$N3(LEXOV) S:LEXDEF=4 LEXN=$$N4(LEXOV)
 S DIR("A",1)="You did not select"_$S(LEXDEF=1:"/create",LEXDEF=2:"/create",1:"")_" a default "_$$UP^XLFSTR(LEXYPE)_", however you already"
 S DIR("A",2)="have a default "_$$UP^XLFSTR(LEXYPE)_" on file.  Did you want to delete"
 S DIR("A",3)="your current default?",DIR("A",4)="",DIR("A",5)="   "_LEXN,DIR("A",6)=""
 S DIR("A")="Delete?  ",DIR("B")="NO",DIR(0)="YAO" D ^DIR K DIR S LEXDEF=+Y Q
 ;
 ; Get default names (N1, N2, N3, and N4)
 ;
 ;   Input   LEXX - The actual value for the default
 ;   Returns LEXX - The name of the default value
 ;
N1(LEXX) ; Filter name
 Q:'$L($G(LEXX)) "Unknown filter"
 N LEXSS,LEXN,LEXSO,LEXI,LEXSP S LEXN="",LEXSP=0,LEXSS=$E(LEXX,1,63)
 S LEXSO=$E(LEXSS,1,($L(LEXSS)-1))_$C($A($E(LEXSS,$L(LEXSS)))-1)_"~"
 F  S LEXSO=$O(^LEX(757.3,"AS",LEXSO)) Q:+LEXSP!(LEXSO'[LEXSS)  D
 . S LEXI=0 F  S LEXI=$O(^LEX(757.3,"AS",LEXSO,LEXI)) Q:+LEXI=0!(+LEXSP'=0)  D
 . . S:$G(^LEX(757.3,+LEXI,1))=LEXX LEXSP=LEXI
 . . S:+LEXSP>0 LEXN=$P($G(^LEX(757.3,+LEXSP,0)),"^",1)
 S LEXX=$S($L(LEXN):LEXN,1:"User defined") Q LEXX
N2(LEXX) ; Display name
 Q:'$L($G(LEXX)) "Unknown display"
 N LEXDP,LEXDS,LEXN S LEXDP=0,LEXN="",LEXDS=$E(LEXX,1,63)
 S LEXDS=$E(LEXDS,1,($L(LEXDS)-1))_$C($A($E(LEXDS,1,$L(LEXDS)))-1)_"~"
 F  S LEXDS=$O(^LEX(757.31,"ADSP",LEXDS)) Q:LEXDS'[LEXX!($L($G(LEXN)))  D
 . S LEXDP=0 F  S LEXDP=$O(^LEX(757.31,"ADSP",LEXDS,LEXDP)) Q:+LEXDP=0!($L($G(LEXN)))  D
 . . I ^LEX(757.31,+LEXDP,1)=LEXX S LEXN=$P(^LEX(757.31,+LEXDP,0),"^",1)
 S LEXX=$S($L(LEXN):LEXN,1:"User defined") Q LEXX
N3(LEXX) ; Vocabulary name
 Q:'$L($G(LEXX)) "Unknown vocabulary"
 Q:'$D(^LEXT(757.2,"AA",LEXX)) "Unknown vocabulary"
 N LEXN S LEXN=$P($G(^LEXT(757.2,$O(^LEXT(757.2,"AA",LEXX,0)),0)),"^",1)
 S LEXX=$S($L(LEXN):LEXN,1:"Unknown vocabulary") Q LEXX
N4(LEXX) ; Context name
 Q:'$L($G(LEXX)) "Unknown context" Q:+LEXX=0 "Unknown context"
 Q:'$D(^LEX(757.41,LEXX)) "Unknown context" N LEXN S LEXN=$P($G(^LEX(757.41,+LEXX,0)),"^",1)
 S LEXX=$S($L(LEXN):LEXN,1:"Unknown context") Q LEXX
