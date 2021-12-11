public class TransientDemo_CC {
	DateTime nonTransientVariable;
    transient DateTime transientVariable;
    
    public String getNonTransientVariable() {
        if(this.nonTransientVariable == null) {
            this.nonTransientVariable = System.now();
        }
        
        return '' + this.nonTransientVariable;
    }
    
    public String getTransientVariable() {
        if(this.transientVariable == null) {
            this.transientVariable = System.now();
        }
        
        return '' + this.transientVariable;
    }
    
    public void refresh(){}
}