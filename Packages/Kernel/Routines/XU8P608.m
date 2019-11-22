XU8P608 ;IRMFO-ALB/CJM - Kernel Lock Manager ;11/28/2012
 ;;8.0;KERNEL;**608**;JUL 10, 1995;Build 84
 ;;
 ;
 ;  ******************************************************************
 ;  *                                                                *
 ;  *  The Kernel Lock Manager is based on the VistA Lock Manager    *
 ;  *        developed by Tommy Martin.                              *
 ;  *                                                                *
 ;  ******************************************************************
 ;
POST ;
 ;D PATCH^ZTMGRSET(608)
 D INPUT2
 Q
INPUT1 ;
 ;Not needed - replaced by patch xu*8.0*607
 N LINE,OFFSET,LOCKIEN,SUBIEN,RTN
 S RTN="XU8P608A"
 S OFFSET=1
 F  S LINE=$T(LOCKS+OFFSET^@RTN) Q:'$L(LINE)  Q:$P(LINE,";;",2)="EXIT"  S OFFSET=OFFSET+1 D
 .I $P(LINE,";",3)="LOCK" S LOCKIEN=$$LOCK($P(LINE,";",4,99)) Q:LOCKIEN  I 'LOCKIEN D BMES^XPDUTL("Failed to create an entry in the XULM LOCK DICTIONARY file for "_$P(LINE,";",4,99)) Q
 .Q:'LOCKIEN
 .I $P(LINE,";",3)="PACKAGE" D  Q
 ..N PACKAGE,DATA
 ..S PACKAGE=$P(LINE,";",4)
 ..S PACKAGE=$O(^DIC(9.4,"B",PACKAGE,0))
 ..I PACKAGE S DATA(1.01)=PACKAGE D UPD^XULMU(8993,LOCKIEN,.DATA)
 .I $P(LINE,";",3)="PARTIAL MATCH OK?" D  Q
 ..N DATA
 ..S DATA(1.03)=$P(LINE,";",4)
 ..D UPD^XULMU(8993,LOCKIEN,.DATA)
 .I $P(LINE,";",3)="USAGE" D  Q
 ..S ^XLM(8993,LOCKIEN,4,0)=$P(LINE,";",4,99)
 ..N CNT S CNT=0
 ..F  S LINE=$T(LOCKS+OFFSET^@RTN) Q:$E(LINE,2,4)'=";;;"  D
 ...S OFFSET=OFFSET+1
 ...S LINE=$P(LINE,";;;",2,99)
 ...S CNT=CNT+1
 ...S ^XLM(8993,LOCKIEN,4,CNT,0)=LINE
 .I $P(LINE,";",3)="SUBSCRIPT" D  Q
 ..N DA,DATA
 ..S LINE=$P(LINE,";",4,99)
 ..S DATA(.01)=$P(LINE,"^")
 ..S DATA(.02)=$P(LINE,"^",2)
 ..S DATA(.04)=$P(LINE,"^",4)
 ..S DA(1)=LOCKIEN
 ..S SUBIEN=$$ADD^XULMU(8993.02,.DA,.DATA)
 .I $P(LINE,";",3)="CHECK LOGIC" D
 ..S:LOCKIEN&SUBIEN ^XLM(8993,LOCKIEN,2,SUBIEN,1)=$P(LINE,";",4,99)
 .I $P(LINE,";",3)="FILE REFERENCE" D  Q
 ..N DA,DATA
 ..S DATA(.01)=$P(LINE,";",4)
 ..S DA(1)=LOCKIEN
 ..S SUBIEN=$$ADD^XULMU(8993.03,.DA,.DATA)
 .I $P(LINE,";",3)="L" D
 ..N CODE,X
 ..S (CODE,X)=$P(LINE,";",4,99)
 ..D:$L(X) ^DIM
 ..I '$D(X) D BMES^XPDUTL("Failed syntax check:"),BMES^XPDUTL(CODE) Q
 ..S:LOCKIEN&SUBIEN ^XLM(8993,LOCKIEN,3,SUBIEN,1)=$G(X)
 .I $P(LINE,";",3)="REFERENCE DESCRIPTION" D  Q
 ..S:SUBIEN&LOCKIEN ^XLM(8993,LOCKIEN,3,SUBIEN,2,0)=$P(LINE,";",4,99)
 ..N CNT S CNT=0
 ..F  S LINE=$T(LOCKS+OFFSET^@RTN) Q:$E(LINE,2,4)'=";;;"  D
 ...S OFFSET=OFFSET+1
 ...S LINE=$P(LINE,";;;",2,99)
 ...S CNT=CNT+1
 ...S:LOCKIEN&SUBIEN ^XLM(8993,LOCKIEN,3,SUBIEN,2,CNT,0)=LINE
 Q
LOCK(LOCK) ;Deletes the old entry and adds a new one.
 N DATA,DA,QUIT,ERROR
 S QUIT=0
 S DATA(.01)=$P(LOCK,"^",2,99)
 S DATA(1.02)=$S($E(LOCK)="^":1,1:0)
 S DA=$O(^XLM(8993,"E",DATA(1.02),DATA(.01),0))
 I DA D DELETE^XULMU(8993,DA)
 Q $$ADD^XULMU(8993,,.DATA,.ERROR)
 ;
 K DATA
 F  S LINE=$T(LOCKS+OFFSET^@RTN),OFFSET=OFFSET+1 D  Q:QUIT
 .N DATA
 .I $P(LINE,";",3)="SUBSCRIPT" D  Q
 ..N PARENT S PARENT=DA N DA
 ..S LINE=$P(LINE,";",4,99)
 ..S DATA(.01)=$P(LINE,"^")
 ..S DATA(.02)=$P(LINE,"^",2)
 ..S DATA(.04)=$P(LINE,"^",4)
 ..S DA(1)=PARENT
 ..S DA=$$ADD^XULMU(8993.02,.DA,.DATA)
 ..S LINE=$T(LOCKS+OFFSET^@RTN)
 .S OFFSET=OFFSET-1,QUIT=1
 Q
 ;
INPUT2 ;Add system lock list to parameters
 N IEN,LOCK,RTN,OFFSET,TEXT,EXIT,SITE
 S EXIT=0
 S IEN=$O(^XLM(8993.1,0))
 I 'IEN D
 .N DATA
 .S SITE=+$$SITE^VASITE
 .I SITE<1 S SITE=$O(^XTV(8989.3,0)) I SITE S SITE=$P($G(^XTV(8989.3,SITE,"XUS")),"^",17)
 .I 'SITE S SITE="NOT YET ENTERED"
 .S DATA(.01)=SITE
 .S IEN=$$ADD^XULMU(8993.1,,.DATA)
 S RTN="XU8P608B"
 S OFFSET=1
 F  S TEXT=$T(LOCKS+OFFSET^@RTN) Q:'$L(TEXT)  Q:EXIT  D
 .S LOCK=$P(TEXT,";;",2,99)
 .I LOCK="" S EXIT=1 Q
 .I LOCK="EXIT" S EXIT=1 Q
 .S OFFSET=OFFSET+1
 .Q:$D(^XLM(8993.1,"AC",LOCK))
 .N DATA,DA
 .S DA(1)=IEN
 .I $E(LOCK,1)="^" D
 ..S DATA(.01)=$P($P(LOCK,"^",2,99),"(")
 ..S DATA(.02)=$P(LOCK,"^",2,99)
 ..S DATA(.03)=1
 .E  D
 ..S DATA(.01)=$P(LOCK,"(")
 ..S DATA(.02)=LOCK
 ..S DATA(.03)=0
 .D ADD^XULMU(8993.15,.DA,.DATA)
 ;
 Q
 ;
