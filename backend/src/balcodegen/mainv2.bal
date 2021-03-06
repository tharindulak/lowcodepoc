// import ballerina/io;
import lowCode/accuweather;
import lowCode/datamapper;
import lowCode/twilio;


public function main() {
    accuweather:Client accuweatherClient= new({ apiKey: "8dbh68Zg2J6WxAK37Cy2jVJTSMdnyAmV"});
    json accuweatherResult = <json> accuweatherClient->weatherToday(zip= "80000");

    json dataMapperResult = <json> datamapper:datamapper({mapping: string `Today is ${<string>accuweatherResult.dayWeather} and the night is ${<string>accuweatherResult.nightWeather}. Today's maximum temprature is ${<string>accuweatherResult.maxTemp}F and the minimum temprature is ${<string>accuweatherResult.minTemp}F. Have a great day!! ~this is ur Ballerina weather bot`});

    twilio:Client twilioClient = new({ accountSId: "ACb2e9f049adcb98c7c31b913f8be70733",
                                       authToken: "77fafc6fadcf31e09dde5a0557fee3f5",
                                       xAuthyKey: ""
                                     });
    json twillioResult = <json> twilioClient->sendWhatsAppMessage(
                                       fromNumber = "+14155238886",
                                       toNumber = "+94773898282",
                                       msg = <string>dataMapperResult.mapping);
}
