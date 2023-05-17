import { LightningElement } from 'lwc';

export default class SimpleCalculator extends LightningElement 
{
    input1;
    input2;
    result;
    action;
    isResult = false;

    handleChange(event)
    {
      
       if(event.target.value != null && event.target.value != ""){
        event.target.name == "input1"?this.input1=parseInt(event.target.value):this.input2=parseInt(event.target.value);
    /*if(event.target.name == "input1")   {
        this.input1=parseInt(event.target.value); 
    }
    else{
        this.input2=parseInt(event.target.value);
    }*/
    }
    else{
        if(event.target.name == "input1")
            this.input1 = parseInt(event.target.value);
        else if(event.target.name == "input2") 
            this.input2 = parseInt(event.target.value);
        else alert("Please re-enter data");
    }
        console.log(`Value is input1 is : ${this.input1}`);
        console.log(`Value is input2 is : ${this.input2}`);

    }

    handleClick(event)
    { 
        console.log("Inside handelClick")
        this.action = event.target.name;
        console.log(`You clicked on button ${this.action}`);
        if(this.input1 && this.input2) {
        switch (this.action) {
            case 'add' : {
                
                this.result = this.input1+this.input2;
                console.log(`Action is : ${this.action}`);
            }
                break;
            
            case 'subtract' : {
                
                this.result = this.input1-this.input2;
                console.log(`Action is : ${this.action}`);
            }
                break;
            case 'multiply' : {
                
                this.result = this.input1*this.input2;
                console.log(`Action is : ${this.action}`);
            }
                break;
            
            case 'devide' : {
                
                this.result = this.input1/this.input2;
                console.log(`Action is : ${this.action}`);
            }
                break;
            default : {
                alert("Choose the correct option");
            }



        }
    }
    else{
        alert("Please enter values in both input fields before clicking on buttons");
    }
    if(this.result != null)
    {
        this.isResult = true;
    }

    }

}