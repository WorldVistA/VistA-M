IBQLLD1 ;LEB/MRY - LOAD UMR FILE ; 31-MAR-95
 ;;1.0;UTILIZATION MGMT ROLLUP LOCAL;**2,3,4**;Oct 01, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
LOAD ;  -- edit, or add .01 field and admission review data
 N IBDAY,DIC,DIE,DA,IBDAY,X,Y,J
 S IBDATA=IBDATA(0),X=$P($P(IBDATA,"^"),":",2),DIC="^IBQ(538,",DIC(0)="L",DLAYGO=538 D ^DIC I Y>0 D
 .; -- fill 0.n fields.
 .S DA=$P(Y,"^"),DIE=DIC D GETDR,^DIE
 .; -- fill 1.n fields.
 .S IBDATA=IBDATA(1) D GETDR1,^DIE
 .; -- fill multiple continued stay fields
 .D MULTI
 Q
 ;
MULTI ; -- edit, or add .01 field and continued stay data
 S DA(1)=DA,DIC=DIC_DA(1)_",13,"
 S IBDAY=1 F  S IBDAY=$O(IBDATA(IBDAY)) Q:'IBDAY  S IBDATA=IBDATA(IBDAY) D
 .S X=$P($P(IBDATA,"^"),":",2),DIC(0)="L",DIC("P")=$P(^DD(538,13,0),"^",2)
 .D ^DIC I Y>0 S DA=+Y,DIE=DIC D GETDR,^DIE
 Q
 ;
GETDR ; -- data string
 S DR="" F J=1:1:$L(IBDATA,"^")-1 S DR=DR_$P($P(IBDATA,"^",J+1),":")_"////"_$P($P(IBDATA,"^",J+1),":",2)_";"
 Q
GETDR1 ; -- data string with no initial call to ^DIE.
 S DR="" F J=1:1:$L(IBDATA,"^") S DR=DR_$P($P(IBDATA,"^",J),":")_"////"_$P($P(IBDATA,"^",J),":",2)_";"
 Q
 ;
TRANSMIT ;  
 ; -- transmit local message
 K ^TMP("IBQLLD",$J),XMY
 S XMY("G.IBQ ROLLUP")="",XMDUZ="IBQ MONITOR",XMSUB="National Rollup File loaded"
 ;
 S ^TMP("IBQLLD",$J,1,0)="The Utilization Management Rollup has completed"_$S($G(IBQNLD)="L":".",1:" and is ready to transmit.")
 S ^TMP("IBQLLD",$J,2,0)=" "
 S ^TMP("IBQLLD",$J,3,0)="                    Site: "_$P($$SITE^VASITE,"^",3)
 S ^TMP("IBQLLD",$J,4,0)="Number of Records loaded: "_IBREC
 S Y=IBBDT X ^DD("DD") S IBBDT1=Y S Y=IBEDT X ^DD("DD") S IBEDT1=Y
 S ^TMP("IBQLLD",$J,5,0)="           Rollup Period: "_IBBDT1_" - "_IBEDT1
 S Y=$S('$D(IBDNLD):"UNKNOWN",IBDNLD="N":"NATIONAL",IBDNLD="A":"ALL",IBDNLD="L":"LOCAL",1:"RANDOM & DISEASE")
 S ^TMP("IBQLLD",$J,6,0)="             Rollup Type: "_Y_" CASES"
 S XMTEXT="^TMP(""IBQLLD"",$J," D ^XMD
 ;
 K IBBDT1,IBEDT1,Y
 Q
