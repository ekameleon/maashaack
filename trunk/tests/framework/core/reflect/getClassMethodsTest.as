﻿/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2010
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
*/

package core.reflect 
{
    import buRRRn.ASTUce.framework.ArrayAssert;
    import buRRRn.ASTUce.framework.TestCase;

    import system.eden;

    import flash.display.MovieClip;

    public class getClassMethodsTest extends TestCase 
    {
        public function getClassMethodsTest(name:String = "")
        {
            super(name);
        }
        
        public function testGetClassMethods():void
        {
            var i:int ;
            
            var results:Array ;
            var methods:Array ;
            
            var mc:MovieClip = new MovieClip() ;
            methods = 
            [
                "addFrameScript",
                "gotoAndPlay",
                "prevScene",
                "gotoAndStop",
                "nextFrame",
                "play",
                "prevFrame",
                "nextScene",
                "stop"
            ] ;
            
            results = getClassMethods( mc , false ) ;
            assertEquals(results.length, methods.length) ;
            for( i=0 ; i<results.length ; i++ )
            {
                assertTrue( results.indexOf(methods[i]) > -1 , "find the current result failed with the index:" + i + " and the result:" + results[i] ) ;
            }
            
            methods = 
            [
                "getBounds","startDrag","addChildAt","stopDrag",
                "hitTestPoint","startTouchDrag","hitTestObject","stopTouchDrag",
                "globalToLocal3D","getChildIndex","getChildByName","setChildIndex",
                "getChildAt","stop","getObjectsUnderPoint","areInaccessibleObjectsUnderPoint",
                "local3DToGlobal","gotoAndStop","swapChildrenAt","toString",
                "swapChildren","contains","addEventListener","nextFrame",
                "removeEventListener","willTrigger","dispatchEvent","gotoAndPlay",
                "addFrameScript","hasEventListener","prevScene","prevFrame",
                "nextScene","play","localToGlobal","addChild",
                "globalToLocal","getRect","removeChild","removeChildAt"
            ] ;
            
            results = getClassMethods( mc , true ) ;
            assertEquals(results.length, methods.length) ;
            for( i = 0 ; i<results.length ; i++ )
            {
                assertTrue( results.indexOf(methods[i]) > -1 , "find the current result failed with the index:" + i + " and the result:" + results[i] + " results:" + eden.serialize(results) ) ;
            }
        }
        
        public function testGetClassMethodsPrimitive():void
        {
            var methods:Array ;
            
            methods = getClassMethods( [] , false ) ;
            ArrayAssert.assertEquals
            ( 
                [] ,
                methods  
            ) ;
            
            methods = getClassMethods( [] , true ) ;
            ArrayAssert.assertEquals
            ( 
                [] ,
                methods  
            ) ;
        }
    }
}
