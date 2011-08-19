LEXDM ; ISL Default Misc - Mod/Del Sel/Create    ; 09-23-96
 ;;2.0;LEXICON UTILITY;;Sep 23, 1996
 ;
 ; Entry:  S X=$$MOD^LEXDM(X)
 ; Input   X  1=Filter, 2=Display, 3=Vocabulary or 4=Context
 ; Returns  "^^" Double up-arrow, 0 no action taken, 1 Modify
 ;          default entry or "@" delete default entry
 ;
MOD(LEXX) ; Modify or Delete
 ;
 S LEXX=+($G(LEXX)) Q:LEXX<0 0 S LEXX=LEXX\1  Q:LEXX>4 0
 N DIR,X,Y,DIRUT,DTOUT,DUOUT,DIROUT
 S:LEXX=1 DIR("A",1)="search filter" S:LEXX=2 DIR("A",1)="display format"
 S:LEXX=3 DIR("A",1)="vocabulary" S:LEXX=4 DIR("A",1)="shortcut context"
 S:$L($G(DIR("A",1))) DIR("A",1)="User default "_DIR("A",1)
 S DIR("A",3)="  1  Modify",DIR("A",4)="  2  Delete"
 S (DIR("A",2),DIR("A",5))="  "
 S:LEXX=1 DIR(0)="SAO^1:Modify Default Filter;2:Delete Default Filter"
 S:LEXX=2 DIR(0)="SAO^1:Modify Default Display;2:Delete Default Display"
 S:LEXX=3 DIR(0)="SAO^1:Modify Default Vocabulary;2:Delete Default Vocabulary"
 S:LEXX=4 DIR(0)="SAO^1:Modify Default Shortcut Context;2:Delete Default Shortcut Context"
 S DIR("A")="Select:  ",DIR("B")="1"
 D ^DIR S LEXX=$S(X=1:1,X=2:"@",X="@":"@",1:0) S:Y="^^" LEXX=Y Q LEXX
 ;
 ;-----------------------------------------------------------------
 ; Entry:  S X=$$MTH^LEXDM(X)
 ; Input   X  1=Filter, 2=Display
 ; Returns "^^" Timeout or Double-uparrow, "^" Method not
 ;         selected, 1 Select default from a predefined list
 ;         or 2 Create a user defined default
 ;
 ; LEXM   Method of building string
 ; LEXF   Flag, indicates the default type
 ;
MTH(LEXX) ; Method - Select a predefined or Create new
 Q:'$L($G(LEXX)) "" Q:+LEXX'>0 "" Q:+LEXX'<3 ""
 N LEXF,LEXM S LEXF=+LEXX,LEXM=$$METH W:+LEXM=1!(+LEXM=2) !!
 S LEXX=LEXM S:"12"[LEXM LEXX=LEXM
 S:'$L($G(LEXM))!(LEXM="^") LEXX="^" S:LEXM="^^" LEXX="^^"
 Q LEXX
METH(LEXX) ; Select method
 N DIR,X,Y,DIRUT,DTOUT,DUOUT,DIROUT
 I +LEXF=1 D
 . S DIR("A",1)="Search filters (screens) to limit the response"
 . S DIR("A",3)="  1  Select from predefined filters"
 . S DIR("A",4)="  2  Create your own filter"
 . S DIR("??")="^D HF^LEXDM"
 I +LEXF=2 D
 . S DIR("A",1)="Display format to used during look-up"
 . S DIR("A",3)="  1  Select from predefined display formats"
 . S DIR("A",4)="  2  Create your own display format"
 . S DIR("??")="^D HD^LEXDM"
 S (DIR("A",2),DIR("A",5))="  "
 S DIR(0)="SAO^1:Predefined Set;2:Create your own set"
 S DIR("A")="Select:  ",DIR("B")="1"
 D ^DIR S LEXX=$S(+Y>0:+Y,1:Y) S:$D(DTOUT) LEXX="^^" Q LEXX
HF ; Help for filters - DIC("S")
 W !!,"When conducting searches in the Lexicon, you may find that many of the"
 W !,"expressions found are not reasonable in the context of intended use."
 W !,"Many of these ""unreasonable"" expressions can be filtered out during the"
 W !,"search, providing a much smaller and more meaningful list of expressions"
 W !,"to select from.  Several of these filters have been predefined and made "
 W !,"available.  You may select from this list of predefined filters or create"
 W !,"your own." Q
HD ; Help for display - LEXSHOW
 W !!,"When conducting searches in the Lexicon, you may alter the display format"
 W !,"of the selection list.  There are several commonly used displays which"
 W !,"have been predefined and made available.  You may select from this list or"
 W !,"create your own." Q
