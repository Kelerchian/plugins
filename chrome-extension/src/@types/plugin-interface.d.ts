declare interface IDisableable {
    enabled: boolean,
}

declare abstract class PluginBase {
    static friendlyName: string;
    static description: string;
    static version: string;
    static match: RegExp | RegExp[];

    static commands: IPluginDefCommand[];
    static homophones: IPluginDefHomophones;
    static init?: () => void;

    static util: IPluginUtil;

    // don't allow non-static properties
    [propName: string]: never;
    // limit the static members to be functions (doesn't work yet)
    // https://github.com/Microsoft/TypeScript/issues/6480
    // static [propName: string]: null | () => any;
}

// for 3rd party plugins definitions
declare interface IPluginDefHomophones { 
    [s: string]: string 
}

// for 3rd party plugins definitions
declare interface IPluginDefCommand {
    name: string,
    // rsturns processsed transcript result -- an array of args to
    // pass to runOnPage
    match: string | string[] | ((transcript: string) => any[]),
    description?: string,
    test?: () => any,
    run?: (() => any) | ((tabIndex: number) => any),
    runOnPage?: (() => any) | ((number) => any),
    nice?: (match: string) => string,
    delay?: number | number[],
}

declare interface IPluginUtil {
    queryAllFrames: (tagName: string, attrs: string[]) => Promise<any[]>;
    postToAllFrames: (id, fnNames: string | string[], selector?) =>  void;
    // TODO: deprecate in favor of generic postToAllFrames?
    // currently used for fullscreen?
    sendMsgToBeacon: (object) => Promise<any>;
    toggleHelpBox: (boolean) => void;
    getScrollDistance: () => number;
    scrollToAnimated: (HTMLElement) => void;
    isInView: (HTMLElement) => boolean;
    getNoCollisionUniqueAttr: () => string;
}

declare namespace ExtensionUtil {
    function queryActiveTab(tab: object): any;
}

declare interface IActivated {
    activated: boolean,
}
