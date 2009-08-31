﻿/*  Version: MPL 1.1/GPL 2.0/LGPL 2.1   The contents of this file are subject to the Mozilla Public License Version  1.1 (the "License"); you may not use this file except in compliance with  the License. You may obtain a copy of the License at  http://www.mozilla.org/MPL/    Software distributed under the License is distributed on an "AS IS" basis,  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License  for the specific language governing rights and limitations under the  License.    The Original Code is [maashaack framework].    The Initial Developers of the Original Code are  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.  Portions created by the Initial Developers are Copyright (C) 2006-2009  the Initial Developers. All Rights Reserved.    Contributor(s):    Alternatively, the contents of this file may be used under the terms of  either the GNU General Public License Version 2 or later (the "GPL"), or  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),  in which case the provisions of the GPL or the LGPL are applicable instead  of those above. If you wish to allow use of your version of this file only  under the terms of either the GPL or the LGPL, and not to allow others to  use your version of this file under the terms of the MPL, indicate your  decision by deleting the provisions above and replace them with the notice  and other provisions required by the LGPL or the GPL. If you do not delete  the provisions above, a recipient may use your version of this file under  the terms of any one of the MPL, the GPL or the LGPL.*/package system {    import flash.utils.ByteArray;            /**     * A static class for Object utilities.     */    public class Objects     {﻿                /**        * Iterates object members to find a value.        */        public static function contains( o:Object, member:* ):Boolean        {            var m:String;                        for( m in o )            {                //TODO                //if( o is Equatable );                                if( o[m] == member )                {                    return true;                }            }                        return false;        }                /**        * Returns a copy of the object.        */        public static function copy( o:Object, shallow:Boolean = false ):Object        {            if( shallow )            {                //make a shallow copy                var member:String;                var copy:Object = {};                                for( member in o )                {                    copy[ member ] = o[ member ];                }                                return copy;            }            else            {                //reuse the ByteArray representation to copy the primitives of the object                /* note:                   writeObject() / readObject() are not supported in tamarin ByteArray class                */                TAMARIN::exclude                {                    var buffer:ByteArray = new ByteArray();                    buffer.writeObject( o );                    buffer.position = 0;                    return buffer.readObject();                }                                API::RT_0_2_5                {                    return o; //till we implement writeObject() / readObject()                }            }        }                /**        * Returns all the public members of an object,        * either by key or by value.        */        public static function getMembers( o:Object, byValue:Boolean = false ):Array        {            var member:String;            var prop:*;            var members:Array = [];                        if( byValue )            {                for each( prop in o )                {                    members.push( prop );                }                            }            else            {                for( member in o )                {                    members.push( member );                }            }                        return members;        }                public static function isSimple( o:* ):Boolean        {            return false;        }                /**        * Merges the source object properties into the target object.        * If <code>overwrite</code> is true, allow to overwrite the target object properties.        */        public static function merge( source:Object, target:Object, overwrite:Boolean = false ):void        {            var member:String;                        for( member in source )            {                if( !target.hasOwnProperty( member ) || overwrite )                {                    target[ member ] = source[ member ];                }            }        }                /**        * Converts an Object to an Array        * by copying all the object members value to the array indexes.        */        public static function toArray( o:Object ):Array        {            return getMembers( o, true );        }            }}