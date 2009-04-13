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
Portions created by the Initial Developers are Copyright (C) 2006-2009
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

/*
This program is based on zlib-1.1.3, so all credit should go authors
Jean-loup Gailly(jloup@gzip.org) and Mark Adler(madler@alumni.caltech.edu)
and contributors of zlib.
*/

package libraries.zip 
{    import system.Enum;

    /**     * The ZStatus enumeration class.     */    public class ZStatus extends Enum 
    {        
        /**
         * Creates a new ZStatus instance.
         */
        public function ZStatus( value:int = 0 , name:String = "" )
        {            super(value, name);        }
        
        /**
         * The "need dictionary" status (2).
         */
        public static const Z_NEED_DICT:ZStatus = new ZStatus(2, "need dictionary") ;
        
        /**
         * The "need dictionary" status (1).
         */
        public static const Z_STREAM_END:ZStatus = new ZStatus(1, "stream end") ;
        
        /**
         * The default "" status (0).
         */
        public static const Z_OK:ZStatus = new ZStatus( 0 , "" ) ;
        
        /**
         * The "file error" status (-1).
         */
        public static const Z_ERRNO:ZStatus = new ZStatus( -1 , "file error" ) ;
        
        /**
         * The "stream error" status (-2).
         */
        public static const Z_STREAM_ERROR:ZStatus = new ZStatus( -2 , "stream error" ) ;
        
        /**
         * The "data error" status (-3).
         */
        public static const Z_DATA_ERROR:ZStatus = new ZStatus( -3 , "data error" ) ;
        
        /**
         * The "insufficient memory" status (-4).
         */
        public static const Z_MEM_ERROR:ZStatus = new ZStatus( -4 , "insufficient memory" ) ;        
        
        /**
         * The "buffer error" status (-5)
         */
        public static const Z_BUF_ERROR:ZStatus = new ZStatus( -5 , "buffer error" ) ;

        /**
         * The "incompatible version" status (-6)
         */
        public static const Z_VERSION_ERROR:ZStatus = new ZStatus( -6 , "incompatible version" ) ;
        
    }
    
}