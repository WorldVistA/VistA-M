PRCFDA4 ;(Wash ISC)/LKG-PROCESS INVOICE FOR PAYMENT ;26 SEP 95
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
AUTOACCR ;Check if AutoAccrue field answered
 N PRCFBBY,PRCFW,PRCFY,PRCFZ,MOP,DA,DR,DIE
 S PRCFY=$G(^PRC(442,PRCF("PODA"),10,1,0)),PRCFZ=$P($P(PRCFY,U),".")
 S MOP=$P($G(^PRC(442,PRCF("PODA"),0)),U,2)
 S PRCFZ=$S(PRCFZ?2U:PRCFZ,MOP=2:"SO",MOP=21:"SO",1:"MO")
 Q:PRCFZ'="SO"
 I $P($G(^PRC(442,PRCF("PODA"),23)),U,6)]"" Q
 S PRCFBBY=1700+$E($P($G(^PRC(442,PRCF("PODA"),23)),U,2),1,3)
 I PRCFBBY<$$CVNFY^PRCFD8L("IFCAP",5.0) S PRCFW="NO" G AUTOASK
 S PRCFW="YES"
 I $P(PRCFY,".")=921,";10;60;"[(";"_$P(PRCFY,".",2)_";") D
 . I $P(PRCFY,".",2)=60 S PRCFW="YES" Q
 . S PRCFY=$P(PRCFY,U,4),PRCFY=$S(PRCFY?1.N:$P($G(^PRCF(423,PRCFY,1)),U,3),1:"")
 . S PRCFW=$S(PRCFY=6:"YES",PRCFY=7:"YES",1:"NO")
AUTOASK W !,"As the Service Order associated with this Invoice lacks a value for the",!,"  Auto-Accrue Flag, you will now be asked."
 S DIE=442,DR="30//^S X=PRCFW",DA=PRCF("PODA") D ^DIE
 Q
