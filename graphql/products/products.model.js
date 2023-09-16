'use strict';

const getAllProducts = () => {
  return products;
};

const getProductsByPrice = (min, max) => {
  return products.filter(product => {
    return product.price >= min && product.price <= max;
  })
}

const getProductById = (id) => {
  return products.find(product => id === product.id);
}

const addNewProduct = (id, description, price) => {
  const newProduct = {
    id,
    price,
    description,
    reviews: []
  };

  products.push(newProduct);
  return newProduct;
}

const addNewProductReview = ({ id, rating, comment }) => {
  const product = getProductById(id);
  if (product) {
    const review = {
      rating,
      comment
    };
    product.reviews.push(review);
  }
  return product;
}

module.exports = { 
  getAllProducts,
  getProductsByPrice,
  getProductById,
  addNewProduct,
  addNewProductReview
};