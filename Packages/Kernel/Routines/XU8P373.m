XU8P373 ;SFISC/SO- Add Whole File Screen to file 200 ;5:50 AM  13 Dec 2004
 ;;8.0;KERNEL;**373**;Jul 10, 1995
 ; IA # 4579
 ; Test for file header node
 I '$D(^VA(200,0))#2 D MES^XPDUTL("NEW PERSON(#200) file is missing it's File Header node.") Q
 ; Test header node $P#2 for proper construction
 I +$P(^VA(200,0),U,2)'=200 D MES^XPDUTL("The second piece of NEW PERSON(#200) file is not correct.") Q
 ; Add the Whole File Screen
 S ^DD(200,0,"SCR")="I $$SCR200^XUSER"
 ; Add Screen flag to file header if not already there
 I $P(^VA(200,0),U,2)'["s" S $P(^VA(200,0),U,2)=$P(^VA(200,0),U,2)_"s"
 ;
 D MES^XPDUTL("Added Screen to NEW PERSON(#200) file.")
 Q
