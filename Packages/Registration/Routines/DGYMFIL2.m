DGYMFIL2 ;ALB/MLI - Set File Access Codes for MAS files ; October 20, 1994
 ;;5.3;Registration;**49**;Aug 13, 1993
 ;
 ; This routine will loop through the MAS files and show the site's
 ; existing file access and the recommended file access.
 ;
PRINT ; generate listing of existing vs recommended file access
 N BRKLINE,FLAG,I,LINE,PAGE,X
 S (FLAG,PAGE)=0,$P(LINE,"-",80)="",$P(BRKLINE,"- ",41)=""
 D HEADER I FLAG Q
 F I=1:1 S X=$P($T(FILES+I),";;",2) Q:X="QUIT"!FLAG  D
 . N CUR,REC ; cur=current, rec=recommended
 . S REC="@^d^"_$P(X,"^",2,5) ; recommended access (DD always @)
 . S CUR=$G(^DIC(+X,0,"DD"))_"^"_$G(^("RD"))_"^"_$G(^("WR"))_"^"_$G(^("DEL"))_"^"_$G(^("LAYGO"))
 . I $Y>(IOSL-4) D HEADER I FLAG Q
 . W !,$S(CUR=REC:" ",1:"*"),+X S X=$P($G(^DIC(+X,0)),"^",1) W ?8,$E(X,1,30) I $L(X)>30 W "..."
 . D WRITE(CUR) W ! ; write current access
 . I CUR=REC W ?43,"Currently meets recommended levels"
 . E  D WRITE(REC) ; write recommended access
 . W !,BRKLINE
 Q
 ;
 ;
WRITE(X) ; write out the access codes in columns
 ;
 ; input - X as string of dd^rd^wr^del^laygo access
 ;
 W ?43,$P(X,"^",1),?51,$P(X,"^",2),?57,$P(X,"^",3),?65,$P(X,"^",4),?75,$P(X,"^",5)
 Q
 ;
 ;
HEADER ; print header for comparison report
 N DIR,DIRUT,DTOUT,DUOUT,X,Y
 S PAGE=PAGE+1
 I $E(IOST,1,2)="C-",(PAGE>1) S DIR(0)="E" D ^DIR S FLAG='Y I FLAG Q
 W @IOF,!?29,"MAS File Access Report",?70,"PAGE:  ",$J(PAGE,2)
 W !!," File",?8,"File",?54,"File Access Type"
 W !," Number",?8,"Name",?43,"DD",?49,"Read",?55,"Write",?63,"Delete",?73,"Laygo"
 W !,LINE
 Q
 ;
 ;
LOAD ; load files into TMP global
 F I=1:1 S X=$P($T(FILES+I),";;",2) Q:X="QUIT"  S ^TMP($J,"DGYMFILE",+X)=X
 Q
 ;
FILES ; list of file numbers and names for MAS files w/recommended access
 ;;2^D^@^D
 ;;5^@^@^@
 ;;8^@^@^@
 ;;8.1^@^@^@
 ;;8.2^@^@^@
 ;;10^@^@^@
 ;;11^@^@^@
 ;;13^@^@^@
 ;;21^@^@^@
 ;;22^@^@^@
 ;;23^@^@^@
 ;;25^@^@^@
 ;;30^@^@^@
 ;;35^@^@^@
 ;;37^@^@^@
 ;;38.1^D^@^D
 ;;38.5^@^@^@
 ;;38.6^@^@^@
 ;;39.1^@^@^@
 ;;39.2^@^@^@
 ;;39.3^@^@^@
 ;;40.1^@^D^@
 ;;40.15^D^D^D
 ;;40.7^@^@^@
 ;;40.8^@^@^@
 ;;40.9^@^@^@
 ;;41.1^D^D^D
 ;;41.9^@^@^@
 ;;42^D^@^D
 ;;42.4^@^@^@
 ;;42.5^D^D^D
 ;;42.55^@^@^@
 ;;42.6^D^D^D
 ;;42.7^D^D^D
 ;;43^D^@^@
 ;;43.1^D^D^D
 ;;43.11^D^D^D
 ;;43.4^@^@^@
 ;;43.5^D^D^D
 ;;43.61^@^@^@
 ;;43.7^@^@^@
 ;;44^D^@^D
 ;;45^D^@^@
 ;;45.1^@^@^@
 ;;45.2^D^@^D
 ;;45.3^@^@^@
 ;;45.4^@^@^@
 ;;45.5^@^@^@
 ;;45.6^@^@^@
 ;;45.61^@^@^@
 ;;45.62^@^@^@
 ;;45.64^@^@^@
 ;;45.7^D^@^D
 ;;45.81^@^@^@
 ;;45.82^@^@^@
 ;;45.83^@^@^@
 ;;45.84^@^@^@
 ;;45.85^D^@^@
 ;;45.86^@^@^@
 ;;45.87^@^@^@
 ;;45.88^@^@^@
 ;;45.89^@^@^@
 ;;45.9^D^D^D
 ;;45.91^@^@^@
 ;;47^@^@^@
 ;;48^D^@^@
 ;;48.5^@^@^@
 ;;389.9^@^@^@
 ;;391^@^@^@
 ;;391.1^@^@^@
 ;;391.51^@^@^@
 ;;392^@^@^@
 ;;392.1^D^D^D
 ;;392.2^D^D^D
 ;;392.3^@^@^@
 ;;392.4^D^@^D
 ;;393^D^D^D
 ;;393.1^@^@^@
 ;;393.2^@^@^@
 ;;393.3^@^@^@
 ;;393.41^@^@^@
 ;;405^@^@^@
 ;;405.1^D^@^D
 ;;405.2^@^@^@
 ;;405.3^@^@^@
 ;;405.4^D^@^D
 ;;405.5^@^@^@
 ;;405.6^D^@^D
 ;;406.41^D^@^D
 ;;407.5^D^D^D
 ;;407.6^@^@^@
 ;;407.7^@^@^@
 ;;408^@^@^@
 ;;408.11^@^@^@
 ;;408.12^@^@^@
 ;;408.13^@^@^@
 ;;408.21^@^@^@
 ;;408.22^@^@^@
 ;;408.31^@^@^@
 ;;408.32^@^@^@
 ;;408.33^@^@^@
 ;;408.34^@^@^@
 ;;408.41^@^@^@
 ;;408.42^@^@^@
 ;;409.1^@^@^@
 ;;409.2^@^@^@
 ;;409.3^D^D^D
 ;;409.41^@^@^@
 ;;409.42^D^D^D
 ;;409.43^D^D^D
 ;;409.44^D^D^D
 ;;409.45^@^@^@
 ;;409.5^D^D^D
 ;;409.61^@^@^@
 ;;409.62^@^@^@
 ;;409.63^@^@^@
 ;;409.65^@^@^@
 ;;409.66^@^@^@
 ;;409.68^@^@^@
 ;;409.71^D^@^D
 ;;409.72^D^D^D
 ;;409.81^@^@^@
 ;;409.82^D^D^D
 ;;QUIT
