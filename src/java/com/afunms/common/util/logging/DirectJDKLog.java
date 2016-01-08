package com.afunms.common.util.logging;

import java.util.logging.ConsoleHandler;
import java.util.logging.Formatter;
import java.util.logging.Handler;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;


/** 
 * 一个用于实现 <code>java.util.logging commons-logging</code> 的代码
 */
class DirectJDKLog implements Log {
    // 没有理由隐藏 ---- 最好的理由就是不隐藏
    public Logger logger;
    
    /** 
     * 备用的格式和控制的类
     */
    private static final String SIMPLE_FMT="org.apache.tomcat.util.log.JdkLoggerFormatter";
    private static final String SIMPLE_CFG="org.apache.tomcat.util.log.JdkLoggerConfig";

    static {
        if( System.getProperty("java.util.logging.config.class") ==null  &&
                System.getProperty("java.util.logging.config.file") ==null ) {
            // default configuration - it sucks. Let's override at least the 
            // formatter for the console
            try {
                Class.forName(SIMPLE_CFG).newInstance();                
            } catch( Throwable t ) { 
            }
            try {
                Formatter fmt = (Formatter)Class.forName(SIMPLE_FMT).newInstance();
                // it is also possible that the user modifed jre/lib/logging.properties - 
                // but that's really stupid in most cases
                Logger root = Logger.getLogger("");
                Handler handlers[] = root.getHandlers();
                for( int i=0; i< handlers.length; i++ ) {
                    // I only care about console - that's what's used in default config anyway
                    if( handlers[i] instanceof  ConsoleHandler ) {
                        handlers[i].setFormatter(fmt);
                    }
                }
            } catch( Throwable t ) {
                // maybe it wasn't included - the ugly default will be used.
            }
            
        } 
    }
    
    public DirectJDKLog(String name ) {
        logger=Logger.getLogger(name);  
        logger.setLevel(Level.FINE);
        ConsoleHandler consoleHandler = new ConsoleHandler();
        consoleHandler.setFormatter(new SimpleFormatter());
        consoleHandler.setLevel(Level.FINE);
        logger.addHandler(consoleHandler);
        
    }
    
    public final boolean isErrorEnabled() {
        return logger.isLoggable(Level.SEVERE);
    }
    
    public final boolean isWarnEnabled() {
        return logger.isLoggable(Level.WARNING); 
    }
    
    public final boolean isInfoEnabled() {
        return logger.isLoggable(Level.INFO);
    }
    
    public final boolean isDebugEnabled() {
        return logger.isLoggable(Level.FINE);
    }
    
    public final boolean isFatalEnabled() {
        return logger.isLoggable(Level.SEVERE);
    }
    
    public final boolean isTraceEnabled() {
        return logger.isLoggable(Level.FINER);
    }
    
    public final void debug(Object message) {
        log(Level.FINE, String.valueOf(message), null);
    }
    
    public final void debug(Object message, Throwable t) {
        log(Level.FINE, String.valueOf(message), t);
    }
    
    public final void trace(Object message) {
        log(Level.FINER, String.valueOf(message), null);
    }
    
    public final void trace(Object message, Throwable t) {
        log(Level.FINER, String.valueOf(message), t);
    }
    
    public final void info(Object message) {
        log(Level.INFO, String.valueOf(message), null);
    }
    
    public final void info(Object message, Throwable t) {        
        log(Level.INFO, String.valueOf(message), t);
    }
    
    public final void warn(Object message) {
        log(Level.WARNING, String.valueOf(message), null);
    }
    
    public final void warn(Object message, Throwable t) {
        log(Level.WARNING, String.valueOf(message), t);
    }
    
    public final void error(Object message) {
        log(Level.SEVERE, String.valueOf(message), null);
    }
    
    public final void error(Object message, Throwable t) {
        log(Level.SEVERE, String.valueOf(message), t);
    }
    
    public final void fatal(Object message) {
        log(Level.SEVERE, String.valueOf(message), null);
    }
    
    public final void fatal(Object message, Throwable t) {
        log(Level.SEVERE, String.valueOf(message), t);
    }    

    // from commons logging. This would be my number one reason why java.util.logging
    // is bad - design by comitee can be really bad ! The impact on performance of 
    // using java.util.logging - and the ugliness if you need to wrap it - is far
    // worse than the unfriendly and uncommon default format for logs. 
    
    private void log( Level level, String msg, Throwable ex ) {
        if (logger.isLoggable(level)) {
            // Hack (?) to get the stack trace.
            Throwable dummyException=new Throwable();
            StackTraceElement locations[]=dummyException.getStackTrace();
            // Caller will be the third element
            String cname="unknown";
            String method="unknown";
            if( locations!=null && locations.length >2 ) {
                StackTraceElement caller=locations[2];
                cname=caller.getClassName();
                method=caller.getMethodName();
            }
            if( ex==null ) {
                logger.logp( level, cname, method, msg );
            } else {
                logger.logp( level, cname, method, msg, ex );
            }
        }
    }        

    // for LogFactory
    static void release() {
        
    }
    
    static Log getInstance(String name) {
        return new DirectJDKLog( name );
    }
}


