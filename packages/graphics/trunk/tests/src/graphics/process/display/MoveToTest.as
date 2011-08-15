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
  Portions created by the Initial Developers are Copyright (C) 2006-2011
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

package graphics.process.display 
{
    import library.ASTUce.framework.TestCase;

    import flash.display.DisplayObject;
    import flash.display.Sprite;
    
    public class MoveToTest extends TestCase 
    {
        public function MoveToTest(name:String = "")
        {
            super(name);
        }
        
        public var display:DisplayObject ;
        
        public function setUp():void
        {
            display = new Sprite() ;
            
            display.x = 25 ;
            display.y = 25 ;
            display.z = 25 ;
        }
        
        public function tearDown():void
        {
            display = null ;
        }
        
        public function testEmptyConstructor():void
        {
            var process:MoveTo = new MoveTo() ;
            try
            {
                process.run() ;
            }
            catch( e:Error )
            {
                fail( "The task must use logger to notify error and not the basic error notification.") ;
            }
        }
        
        public function testEmptyCoord():void
        {
            var process:MoveTo = new MoveTo( display ) ;
            
            process.run() ;
            
            assertEquals( 25 , display.x , "#1" ) ;
            assertEquals( 25 , display.y , "#2" ) ;
            assertEquals( 25 , display.z , "#3" ) ;
        }
        
        public function testFullConstructor():void
        {
            var process:MoveTo = new MoveTo( display , 100, 200, 300 ) ;
            
            process.run() ;
            
            assertEquals( 100 , display.x , "#1" ) ;
            assertEquals( 200 , display.y , "#2" ) ;
            assertEquals( 300 , display.z , "#3" ) ;
        }
        
        public function testChangeXOnly():void
        {
            var process:MoveTo = new MoveTo( display , 100, NaN, NaN ) ;
            
            process.run() ;
            
            assertEquals( 100 , display.x , "#1" ) ;
            assertEquals(  25 , display.y , "#2" ) ;
            assertEquals(  25 , display.z , "#3" ) ;
        }
        
        public function testChangeYOnly():void
        {
            var process:MoveTo = new MoveTo( display , NaN, 200, NaN ) ;
            
            process.run() ;
            
            assertEquals(  25 , display.x , "#1" ) ;
            assertEquals( 200 , display.y , "#2" ) ;
            assertEquals(  25 , display.z , "#3" ) ;
        }
        
        public function testChangeZOnly():void
        {
            var process:MoveTo = new MoveTo( display , NaN, NaN, 300 ) ;
            
            process.run() ;
            
            assertEquals(  25 , display.x , "#1" ) ;
            assertEquals(  25 , display.y , "#2" ) ;
            assertEquals( 300 , display.z , "#3" ) ;
        }
    }
}