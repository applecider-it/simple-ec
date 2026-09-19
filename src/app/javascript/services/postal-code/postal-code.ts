import axios from 'axios';

/** Zipcloud API のレスポンス型定義 */
interface ZipcloudResult {
  /** 都道府県 */
  address1: string;
  /** 市区町村 */
  address2: string;
  /** 町域 */
  address3: string;

  kana1: string;
  kana2: string;
  kana3: string;

  prefcode: string;
  zipcode: string;
}

interface ZipcloudResponse {
  message: string | null;
  results: ZipcloudResult[] | null;
  status: number;
}

/** 戻り値の型（成功時と失敗時の判別可能なユニオン型） */
type ZipSearchResult = {
  success: boolean;
  data: ZipcloudResult | null;
  message: string;
};

/** 郵便番号から住所情報を取得する */
export const fetchAddressByPostalCode = async (
  postalCode: string,
): Promise<ZipSearchResult> => {
  const result: ZipSearchResult = {
    success: false,
    data: null,
    message: '',
  };
  if (postalCode.length !== 7) {
    result.message = '7桁の郵便番号を正しく入力してください。';
    return result;
  }

  try {
    const response = await axios.get<ZipcloudResponse>(
      'https://zipcloud.ibsnet.co.jp/api/search',
      {
        params: { zipcode: postalCode },
      },
    );

    const results = response.data.results;

    if (!results || results.length === 0) {
      result.message = '該当する住所が見つかりませんでした。';
      return result;
    }

    const data = results[0] as ZipcloudResult;

    result.success = true;
    result.data = data;
    return result;
  } catch (error) {
    console.error(error);

    result.message = '通信エラーが発生しました。';
    return result;
  }
};
