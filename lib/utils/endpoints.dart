
bool isDev = true;
var current_env = env.aws;

final String baseUrl = current_env == env.dev
    ? "http://192.168.0.2:8000/api"
    : current_env == env.aws
        ? "http://primemetricsbackendapis-env.eba-ueznnzk8.eu-west-1.elasticbeanstalk.com/api"
        : "https://primemetrics.branfoot.com/api";
final String signUp = baseUrl + "/user/signup";
final String login = baseUrl + "/user/signIn";
final String SEND_EMAIL = baseUrl + "/user/sendOtp";
final String SOCIAL_SIGNIN = baseUrl + "/user/socialSignIn";
final String veryfy_otp = baseUrl + "/user/verifyOtp";
final String link_account = baseUrl + "/user/link";
final String ACTIVE_TRIP = baseUrl + "/user/trip/active";
final String REFRESH_TOKEN = baseUrl + "/user/token/fresh";
final String GET_COMPANY_TOWNS = baseUrl + "/company/towns/list";
final String COMPANY_VEHICLES = baseUrl + "/vehicle";
final String COMPANY_PRODUCTS = baseUrl + "/company/products";
final String PRODUCT_COMPANIES = baseUrl + "/product/company";
final String START_TRIP = baseUrl + "/user/trip/create";
final String ADD_DESTINATION = baseUrl + "/user/trip/destination";
final String ACTIVE_TRIP_SAMMARY = baseUrl + "/user/trip/active/sammary";
final String ADD_LOADING_POINT = baseUrl + "/user/trip/load";
final String ADD_REFUEL_POINT = baseUrl + "/user/trip/refuel";
final String END_TRIP = baseUrl + "/user/trip/end";
final String CLOSE_TRIP = baseUrl + "/user/trip/close";
final String USER = baseUrl + "/user";


final String RECENT_TRIPS = baseUrl + "/user/recenttrip";
final String DRIVER_LIST = baseUrl + "/user/driverlist";
final String MANUFACTURER = baseUrl + "/company";
final String PRODUCT = baseUrl + "/commodity";
final String FUELING_POINT = baseUrl + "/fuelpointlist";
final String ADD_LAST_TRIP_DETAILS = baseUrl + "/addlasttripdetails";
final String ROUTES = baseUrl + "/routes";

final String STORE_LIST = baseUrl + "/storelist";
final String TYRE_BRAND_LIST = baseUrl + "/brandlist";
final String TYRE_MODEL_LIST = baseUrl + "/modellist";
final String TYRE_SIZE_LIST = baseUrl + "/sizelist";
final String TYRE_SPECIFICATION_LIST = baseUrl + "/tyrespecificationlist";
final String THREAD_PATTERN_LIST = baseUrl + "/treadPatternlist";
final String TYRE_VENDOR = baseUrl + "/vendorlist";

final String TYRE_LIST = baseUrl + "/tyrelist";
final String TYRE_DETAILS_BY_ID = baseUrl + "/tyredetailsbyid";
final String VEHICLE_STRUCTURE = baseUrl + "/vehiclestructure";

final String TYRE_ONBOARDING = baseUrl + "/tyre-onboarding";
final String TYRE_MOUNT = baseUrl + "/tyre-mount";
final String TYRE_UNMOUNT = baseUrl + "/tyre-unmount";



getHost() {
 return  Uri.parse(baseUrl).host;
}

enum env { aws, dev, primemetrics }
