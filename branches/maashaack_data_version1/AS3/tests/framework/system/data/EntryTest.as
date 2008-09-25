﻿/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [MaasHaack framework]
  
  The Initial Developer of the Original Code is
  Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/

package system.data 
{
    import buRRRn.ASTUce.framework.TestCase;    

    public class EntryTest extends TestCase 
    {

        public function EntryTest(name:String = "")
        {
            super( name );
        }
        
        public function testInterface():void
        {
            
            var i:EntryClass = new EntryClass( "key", "value" );
            
            assertTrue( i is Entry ) ;
            
            assertEquals( i.key   , "key"   , "Entry interface failed with the key method" ) ;
            
            assertEquals( i.value , "value" , "Entry interface failed with the value method" ) ;
            
            
        }         
        
    }
}

import system.data.Entry;

class EntryClass implements Entry
{

    private var _key:* ;
    
    private var _value:* ;

    public function EntryClass( key:* , value:* )
    {
        _key   = key ;
        _value = value ;
    }
    
    public function get key():*
    {
    	return _key ;
    }
    
    public function set key( key:* ):void
    {
        _key = key ;
    }    
    
    public function get value():*
    {
    	return _value ;
    }
        
    public function set value( value:* ):void
    {
    	_value = value ;
    }
}