PRC0B2 ;WISC/PLT-TASK/DEVICE/MM UTILITY ; 06/30/94  12:40 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 QUIT  ; invalid entry
 ;
 ;prca date ~1=[label]^routine, ~2=task description
 ;prcb data ~1=variable name/global root, ~2...
 ;prcc data ~1=1 if ask start time, ~2=start time (fm time/$h-time), ~3=keep until time (fm/$h)
 ;          ~4=i/o device name, ~5=priority(1-10),
 ;          ~6=task uci, ~7=volume set,
TASK(PRCA,PRCB,PRCC) ;EF value ^1 task number, ^2=start time(fm/$h)
 ;task set-up
 N ZTRN,ZTDESC,ZTDTH,ZTIO,ZTUCI,ZTCPU,ZTPRI,ZTSAVE,ZTKIL,ZTSK
 N A,B
 S ZTRTN=$P(PRCA,"~"),ZTDESC=$P(PRCA,"~",2)
 I $G(PRCB)]"" F A=1:1 Q:$P(PRCB,"~",A,999)=""  S B=$P(PRCB,"~",A) S:B]"" @("ZTSAVE("""_B_""")=""""")
 S ZTIO=""
 S PRCC=$G(PRCC) S:'PRCC ZTDTH=$S($P(PRCC,"~",2)="":$H,1:$P(PRCC,"~",2))
 I $P(PRCC,"~",3,999)]"" D
 . S:$P(PRCC,"~",3)]"" ZTKILL=$P(PRCC,"~",3)
 . S:$P(PRCC,"~",4)]"" ZTIO=$P(PRCC,"~",4)
 . S:$P(PRCC,"~",5)]"" ZTPRI=$P(PRCC,"~",5)
 . S:$P(PRCC,"~",6)]"" ZTUCI=$P(PRCC,"~",6)
 . S:$P(PRCC,"~",7)]"" ZTCPU=$P(PRCC,"~",7)
 . QUIT
 D ^%ZTLOAD
 QUIT $G(ZTSK)_"^"_$G(ZTSK("D"))
 ;
 ;PRCA data ^1=message subject, ^2=message sender's name (option)
 ;xmtext text array name with left parenthesis
 ;.xmy recipients ri/name, group array
 ;.xmrou rourtine name array
 ;.xmstrip striped character array
MM(PRCA,XMTEXT,XMY,XMROU,XMSTRIP) ;mail message sending
 N XMSUB,XMDUZ
 S XMSUB=$P(PRCA,"^") S:$P(PRCA,"^",2)]"" XMDUZ=$P(PRCA,"^",2)
 D ^XMD
 QUIT
 ;
 ;A=ri of file 3.8
MG(A) ;EF value=mail group name in file 3.8
 D PIECE^PRC0B("3.8;;"_A,.01,"I","A")
 QUIT $G(A(3.8,A,.01,"I"))
 ;
 ;PRCA=package name (.01) in file 9.4
PKGVER(PRCA) ;EF - ^1=ri of file 9.4, ^2=version number from node version if defined
 ;     ^3=version number from node 22, ^4=version install date from node 22
 N A,B,C
 S (A,B)=""
 Q:$D(PRCPKVER(PRCA)) PRCPKVER(PRCA)
 S A=$O(^DIC(9.4,"B",PRCA,""))
 I A S PRCPKVER(PRCA)=A,$P(PRCPKVER(PRCA),"^",2)=$P($G(^DIC(9.4,A,"VERSION")),"^"),$P(PRCPKVER(PRCA),"^",3)=$P(PRCPKVER(PRCA),"^",2) D:$P(PRCPKVER(PRCA),"^",2)=""
 . D EN^DDIOL("Package is defined, but has not current version data.")
 . D EN^DDIOL("Please call IRM!")
 S:'A PRCPKVER(PRCA)=""
 QUIT PRCPKVER(PRCA)
 ;
 ;A=DATE/TIME, B='I' if fileman date, 'H' if $H DATE, 'E' if external date
 ;C="S" if second required
DT(A,B,C) ;EF value: -1 if wrong format,  ^1=fileman.time, ^$h date,time
 ;          ^3-week day, ^4=mm/dd/yy@time, ^5=alpha date@time
 N %DT,X,Y,Z,%H,%,%T,%Y
 S:'$D(C) C="" S Z=""
 I B="E" D  QUIT:Z=-1 Z
 . S %DT="FPT" S:C="S" %DT=%DT_"S"
 . S X=A D ^%DT S Z=Y
 I B="H" D
 . S %H=A D YMD^%DTC S Z=X,%=$P(A,",",2) D S^%DTC S Z=Z_%
 S:Z="" Z=A
 S X=Z D H^%DTC S $P(Z,"^",2)=%H_","_%T,$P(Z,"^",3)=%Y
 S Y=$P(Z,"^") S:C="S" %DT="S" D DD^%DT S $P(Z,"^",5)=Y,A=$P(Y,"@",2)
 S $P(Z,"^",4)=$E(Z,4,5)_"/"_$E(Z,6,7)_"/"_$E(Z,2,3)
 S:$P(Z,"^")["." $P(Z,"^",4)=$P(Z,"^",4)_"@"_$TR(A,":","")
 QUIT Z
