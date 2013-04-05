XT73P133 ;RSD/OAKLAND - Test Routine for XT*7.3*133
 ;;7.3;TOOLKIT;**133**;Apr 25, 1995;Build 15
 ;This routine is only to test XINDEX for patch 133. It contains several
 ; different formats for Cache Objects.
 Q
 SET STATUS=##class(%XML.TextReader).ParseStream(STREAM,.READER,,,,,1)
 SET XOBSTAT=$System.OBJ.DeletePackage("xobw")
 SET XOBSTRM=##class(%FileCharacterStream).%New()
 SET X=XOBSTRM.ReadLine(XOBJECT)
 DO $System.OBJ.DisplayError(%OBJLASTERROR)
 Q
